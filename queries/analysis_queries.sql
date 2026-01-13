-- Analytical SQL queries for Futures & Options data

-- 1. Top 10 symbols by total open interest
SELECT i.symbol,
       SUM(t.open_interest) AS total_open_interest
FROM trades t
JOIN expiry e ON t.expiry_id = e.expiry_id
JOIN instrument i ON e.instrument_id = i.instrument_id
GROUP BY i.symbol
ORDER BY total_open_interest DESC
LIMIT 10;

-- Sample Output:
-- symbol       | total_open_interest
-- -------------|---------------------
-- NIFTY        | 125430000
-- BANKNIFTY    | 98234000
-- RELIANCE     | 65432000


-- 2. Average daily volume by symbol
SELECT i.symbol,
       AVG(t.volume) AS avg_daily_volume
FROM trades t
JOIN expiry e ON t.expiry_id = e.expiry_id
JOIN instrument i ON e.instrument_id = i.instrument_id
GROUP BY i.symbol
ORDER BY avg_daily_volume DESC;

-- Sample Output:
-- symbol       | avg_daily_volume
-- -------------|------------------
-- BANKNIFTY    | 1200000
-- NIFTY        | 980000


-- 3. 7-day rolling volatility for NIFTY
SELECT t.trade_timestamp,
       STDDEV(t.close_price) OVER (
           ORDER BY t.trade_timestamp
           ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
       ) AS rolling_volatility
FROM trades t
JOIN expiry e ON t.expiry_id = e.expiry_id
JOIN instrument i ON e.instrument_id = i.instrument_id
WHERE i.symbol = 'NIFTY';

-- Sample Output:
-- trade_timestamp       | rolling_volatility
-- ---------------------|-------------------
-- 2023-08-10 09:15:00  | 42.35
-- 2023-08-11 09:15:00  | 38.12


-- 4. Option chain summary by expiry and strike price
SELECT e.expiry_date,
       e.strike_price,
       e.option_type,
       SUM(t.volume) AS total_volume
FROM trades t
JOIN expiry e ON t.expiry_id = e.expiry_id
GROUP BY e.expiry_date, e.strike_price, e.option_type
ORDER BY e.expiry_date, e.strike_price;

-- Sample Output:
-- expiry_date | strike_price | option_type | total_volume
-- ------------|--------------|-------------|-------------
-- 2023-08-31  | 18000        | CE          | 456780
-- 2023-08-31  | 18000        | PE          | 398120


-- 5. Highest traded symbols in the last 30 days
SELECT i.symbol,
       MAX(t.volume) AS max_volume
FROM trades t
JOIN expiry e ON t.expiry_id = e.expiry_id
JOIN instrument i ON e.instrument_id = i.instrument_id
WHERE t.trade_timestamp >= CURRENT_DATE - INTERVAL '30 days'
GROUP BY i.symbol
ORDER BY max_volume DESC;

-- Sample Output:
-- symbol       | max_volume
-- -------------|-----------
-- BANKNIFTY    | 3400000
-- NIFTY        | 2900000
