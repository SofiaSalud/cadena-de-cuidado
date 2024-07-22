import json
import pandas as pd

from sqlalchemy import create_engine
from google.cloud import bigquery
from google.oauth2 import service_account


# Configuración de la conexión a PostgreSQL
PGHOST = ""
PGPORT = ""
PGDATABASE = ""
PGUSER = ""
PGPASSWORD = ""
SCHEMA = "common"

# Configuración de la conexión a BigQuery
PROJECT_ID = "sofia-data-305018"
DATASET_ID = "common_20240702"

# Your JSON string with the credentials
credential_json_path = ""
with open(credential_json_path, 'rb') as f:
    credentials_dict = json.load(f)

# Create a credentials object from the dictionary
credentials = service_account.Credentials.from_service_account_info(credentials_dict)


# Create a credentials object from the dictionary
credentials = service_account.Credentials.from_service_account_info(credentials_dict)

# Crear el cliente de BigQuery
client = bigquery.Client(project=PROJECT_ID, credentials=credentials)

# Conectar a la base de datos PostgreSQL
engine = create_engine(f"postgresql+psycopg2://{PGUSER}:{PGPASSWORD}@{PGHOST}:{PGPORT}/{PGDATABASE}")

# Función para convertir tipos de datos de PostgreSQL a BigQuery
def convert_types(df):
    for column in df.columns:
        if df[column].dtype == 'int64':
            df[column] = df[column].astype('Int64')  # Pandas extension type to handle missing integers
        elif df[column].dtype == 'float64':
            df[column] = df[column].astype('float')
        elif df[column].dtype == 'bool':
            df[column] = df[column].astype('boolean')  # Pandas extension type to handle missing booleans
        elif df[column].dtype == 'datetime64[ns]':
            df[column] = df[column].astype('datetime64[ns]')
        elif df[column].dtype == 'object':
            df[column] = df[column].astype('str')
        elif df[column].dtype.name == 'category':
            df[column] = df[column].astype('str')
        elif pd.api.types.is_object_dtype(df[column]) and df[column].apply(lambda x: isinstance(x, list)).all():
            df[column] = df[column].apply(lambda x: ','.join(map(str, x)) if isinstance(x, list) else str(x))
    return df

# Obtener la lista de tablas
tables = pd.read_sql(f"SELECT table_name FROM information_schema.tables WHERE table_schema = '{SCHEMA}'", engine)

# Exportar cada tabla a BigQuery
for table in tables['table_name']:
    print(f"Exportando tabla {table} a BigQuery")
    df = pd.read_sql(f"SELECT * FROM {SCHEMA}.{table}", engine)
    df = convert_types(df)
    table_id = f"{PROJECT_ID}.{DATASET_ID}.{table}"
    df.to_gbq(table_id, project_id=PROJECT_ID, if_exists='replace', credentials=credentials)

print("Exportación completada")
