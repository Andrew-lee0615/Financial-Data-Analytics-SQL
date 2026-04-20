-- Project 06: Archiving Correlation Analysis Results
-- Context: Testing 'Digital Gold' Hypothesis (BTC vs. GLD vs. QQQ)

/* 1. Create Table for Correlation Logs
Storing rolling correlation results to track asset decoupling over time.
*/
CREATE TABLE IF NOT EXISTS Asset_Correlation_Logs (
    analysis_date DATE,
    base_ticker VARCHAR(10),        -- 'BTC-USD'
    compare_ticker VARCHAR(10),     -- 'QQQ', 'GLD'
    correlation_value DECIMAL(5, 4), 
    window_days INT DEFAULT 60,      
    event_tag VARCHAR(50),          -- 'Operation Epic Fury'
    PRIMARY KEY (analysis_date, base_ticker, compare_ticker)
);

/* 2. Insert Empirical Results from Python Analysis
BTC vs. QQQ: 0.3634 (Risk-on Coupling)
BTC vs. GLD: 0.0945 (Safe-haven Decoupling)
*/
INSERT INTO Asset_Correlation_Logs 
VALUES ('2026-04-20', 'BTC-USD', 'QQQ', 0.3634, 60, 'Operation Epic Fury');

INSERT INTO Asset_Correlation_Logs 
VALUES ('2026-04-20', 'BTC-USD', 'GLD', 0.0945, 60, 'Operation Epic Fury');

/* 3. Verification Query
Retrieve assets that act more like Risk-on assets (> 0.3 correlation)
*/
SELECT * FROM Asset_Correlation_Logs
WHERE base_ticker = 'BTC-USD' 
AND correlation_value >= 0.3
ORDER BY correlation_value DESC;
