-- DDL: Table creation for Futures & Options database

CREATE TABLE exchange (
    exchange_id SERIAL PRIMARY KEY,
    exchange_code VARCHAR(10) UNIQUE NOT NULL,
    exchange_name VARCHAR(50)
);

CREATE TABLE instrument (
    instrument_id BIGSERIAL PRIMARY KEY,
    symbol VARCHAR(30) NOT NULL,
    instrument_type VARCHAR(20)
);

CREATE TABLE expiry (
    expiry_id BIGSERIAL PRIMARY KEY,
    instrument_id BIGINT NOT NULL,
    expiry_date DATE NOT NULL,
    strike_price NUMERIC(10,2),
    option_type VARCHAR(2),
    CONSTRAINT fk_instrument
        FOREIGN KEY (instrument_id)
        REFERENCES instrument(instrument_id)
);

CREATE TABLE trades (
    trade_id BIGSERIAL PRIMARY KEY,
    expiry_id BIGINT NOT NULL,
    exchange_id INT NOT NULL,
    trade_timestamp TIMESTAMP NOT NULL,
    open_price NUMERIC(10,2),
    high_price NUMERIC(10,2),
    low_price NUMERIC(10,2),
    close_price NUMERIC(10,2),
    settle_price NUMERIC(10,2),
    volume BIGINT,
    open_interest BIGINT,
    CONSTRAINT fk_expiry
        FOREIGN KEY (expiry_id)
        REFERENCES expiry(expiry_id),
    CONSTRAINT fk_exchange
        FOREIGN KEY (exchange_id)
        REFERENCES exchange(exchange_id)
);
