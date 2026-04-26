import snowflake.connector
import pandas as pd
import os
from snowflake.connector.pandas_tools import write_pandas

# ── Config (set these as environment variables before running) ─────────
SNOWFLAKE_USER    = os.environ.get("SNOWFLAKE_USER")
SNOWFLAKE_PASSWORD = os.environ.get("SNOWFLAKE_PASSWORD")
SNOWFLAKE_ACCOUNT = os.environ.get("SNOWFLAKE_ACCOUNT")

# ── Load clean CSV ─────────────────────────────────────────────────────
df = pd.read_csv("data/raw/mta_ridership.csv")
df.columns = [col.upper() for col in df.columns]
print(f"Loaded {len(df)} rows from CSV")

# ── Connect to Snowflake ───────────────────────────────────────────────
conn = snowflake.connector.connect(
    user=SNOWFLAKE_USER,
    password=SNOWFLAKE_PASSWORD,
    account=SNOWFLAKE_ACCOUNT,
    warehouse="TRANSIT_WH",
    database="TRANSIT_DB",
    schema="RAW"
)

# ── Create table and load ──────────────────────────────────────────────
cursor = conn.cursor()
cursor.execute("""
CREATE OR REPLACE TABLE TRANSIT_DB.RAW.MTA_RIDERSHIP (
    TRANSIT_TIMESTAMP     VARCHAR,
    TRANSIT_MODE          VARCHAR,
    STATION_COMPLEX_ID    VARCHAR,
    STATION_COMPLEX       VARCHAR,
    BOROUGH               VARCHAR,
    PAYMENT_METHOD        VARCHAR,
    FARE_CLASS_CATEGORY   VARCHAR,
    RIDERSHIP             FLOAT,
    TRANSFERS             FLOAT,
    LATITUDE              FLOAT,
    LONGITUDE             FLOAT,
    GEOREFERENCE          VARCHAR
)
""")

success, nchunks, nrows, _ = write_pandas(conn, df, "MTA_RIDERSHIP", overwrite=True)
print(f"Loaded {nrows} rows in {nchunks} chunks — success: {success}")

conn.close()