CREATE TABLE IF NOT EXISTS clean_table AS 
SELECT * FROM raw_table WITH NO DATA;

CREATE OR REPLACE FUNCTION transform_data(start_date DATE, end_date DATE)
RETURNS VOID AS $$
BEGIN
    DELETE FROM raw_table
    WHERE "Report_date" IS NULL
    OR COALESCE("userID", "Track", artist, genre, "City", CAST(time AS text), "Weekday") IS NULL;

    INSERT INTO clean_table
    SELECT *
    FROM raw_table
    WHERE "Report_date" BETWEEN start_date AND end_date
    AND "Report_date" BETWEEN '2023-01-01' AND '2023-12-31';
END;
$$ LANGUAGE plpgsql;

SELECT * FROM clean_table;
