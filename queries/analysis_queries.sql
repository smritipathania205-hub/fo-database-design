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

-- 2. Average daily volume by symbol
SELECT i.symbol,
       AVG(t.volume) AS avg_daily_volume
FROM trades t
JOIN expiry e ON t.expiry_id = e.expiry_id
JOIN instrument i ON e.instrument_id = i.instrument_id
GROUP BY i.symbol
ORDER BY avg_daily_volume DESC;

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

-- 4. Option chain summary
SELECT e.expiry_date,
       e.strike_price,
       e.option_type,
       SUM(t.volume) AS total_volume
FROM trades t
JOIN expiry e ON t.expiry_id = e.expiry_id
GROUP BY e.expiry_date, e.strike_price, e.option_type
ORDER BY e.expiry_date, e.strike_price;

-- 5. Highest traded symbols in last 30 days
SELECT i.symbol,
       MAX(t.volume) AS max_volume
FROM trades t
JOIN expiry e ON t.expiry_id = e.expiry_id
JOIN instrument i ON e.instrument_id = i.instrument_id
WHERE t.trade_timestamp >= CURRENT_DATE - INTERVAL '30 days'
GROUP BY i.symbol
ORDER BY max_volume DESC;
