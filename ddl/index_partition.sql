-- Indexes for performance optimization on high-volume Trades table

CREATE INDEX idx_trades_timestamp ON trades (trade_timestamp);
CREATE INDEX idx_trades_exchange ON trades (exchange_id);
CREATE INDEX idx_expiry_instrument ON expiry (instrument_id);

-- Partitioning Strategy (Design Reference)
-- In a production setup, the trades table can be partitioned by expiry_date
-- or exchange_id to improve query performance for large datasets (10M+ rows).
