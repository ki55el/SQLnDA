import pandas as pd
from sqlalchemy import create_engine

file_path = 'music.xlsx'
data = pd.read_excel(file_path)
engine = create_engine('postgresql://postgres:12345@localhost:5432/music')
data.to_sql('raw_table', engine, if_exists='replace', index=False)

print("Данные успешно загружены в PostgreSQL.")
