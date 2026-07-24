import pandas as pd
from sqlalchemy import create_engine
from sqlalchemy.engine import URL

url = URL.create(
    drivername="postgresql+psycopg2",
    username="postgres",
    password="Sql2701",
    host="localhost",
    port=5432,
    database="superstore_db"
)

engine = create_engine(url)

def run_query(query):
    return pd.read_sql(query, engine)