import duckdb

# Connect to DuckDB (creates a local database file)
con = duckdb.connect("fo_database.duckdb")

# Load Kaggle CSV into a staging table
con.execute("""
CREATE TABLE raw_fo_data AS
SELECT *
FROM read_csv_auto('NSE_FO_3M.csv');
""")

# Verify data load
result = con.execute("SELECT COUNT(*) FROM raw_fo_data;").fetchone()
print("Total rows loaded:", result[0])
