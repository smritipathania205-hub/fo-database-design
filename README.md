# Futures & Options Database Design – Senior Data Associate Assignment

## Overview

This assignment focuses on designing a relational database to store and analyze high-volume Futures & Options (F&O) market data. The dataset used is the NSE Future and Options Dataset (3M) from Kaggle, which contains millions of rows with repeated information such as symbols, expiry dates, and exchanges.

The objective of this project is to organize the raw data into a clean, scalable database structure and demonstrate how SQL can be used to analyze trading data efficiently.

---

## Dataset Used

- **Source:** Kaggle – NSE Future and Options Dataset (3M)
- **Data Type:** Futures & Options market data
- **Size:** 2.5M+ rows
- **Key Columns:**
  - Symbol
  - Instrument type
  - Expiry date
  - Strike price
  - Option type (CE / PE)
  - Prices (Open, High, Low, Close, Settle)
  - Volume
  - Open Interest
  - Timestamp

Although the dataset contains only NSE data, the database design supports multiple exchanges such as NSE, BSE, and MCX.

---

## Database Design Approach

The raw CSV file contained a large amount of repeated data, making it difficult to analyze directly. To address this, the database was designed using normalization principles (3NF) by separating repeating information into different tables and keeping time-based trading data in a central table.

---

## Tables Designed

### 1. Exchange
Stores the list of exchanges from which the data is sourced.

- Examples: NSE, BSE, MCX
- Prevents repeated storage of exchange names

---

### 2. Instrument
Stores the symbols or instruments being traded.

- Examples: NIFTY, BANKNIFTY, GOLD
- Symbols appear multiple times in raw data and are stored once here

---

### 3. Expiry
Stores contract-level details for Futures and Options.

- Expiry date
- Strike price
- Option type (CE / PE)

Each row represents a unique contract.

---

### 4. Trades (Main Table)
Stores the actual time-based trading activity.

Includes:
- Timestamp
- Prices (Open, High, Low, Close, Settle)
- Volume
- Open Interest
- References to Exchange and Expiry tables

This is the largest table and contains most of the data.

---

## Entity Relationship Design

- One Exchange can have many Trades
- One Instrument can have many Expiries
- One Expiry can have many Trades

This design keeps the data organized and scalable for large datasets.

---

## SQL Queries Implemented

SQL queries were written to answer common analytical questions, including:

- Identifying symbols with high trading activity
- Analyzing changes in open interest
- Calculating price volatility over time
- Comparing data across different exchanges
- Generating option chain summaries

---

## Performance Optimization

Since the Trades table contains millions of records, basic performance optimizations were applied:

- Indexes on timestamp, exchange, and symbol
- Design supports partitioning by date or exchange if required

Indexing helps improve query performance by reducing full table scans.

---

## Tools Used

- **Database:** PostgreSQL / DuckDB
- **ER Diagram:** dbdiagram.io
- **Data Source:** Kaggle CSV files
- **SQL:** Used for table creation and analytical queries

---

## Conclusion

This project demonstrates how large Futures & Options datasets can be organized into a structured relational database. By separating reference data from time-based trading data, the design avoids redundancy, improves clarity, and scales efficiently for high-volume data analysis.

---

## Repository Structure

fo-database-design/
├── README.md
├── ddl/
│ └── create_tables.sql
├── queries/
│ └── analysis_queries.sql
├── docs/
│ └── ER_Diagram.pdf
