-- Project 08: JPY Carry Trade Unwinding & Market Contagion Analysis
-- Context: Analyzing the correlation between JPY strength and Global Risk Assets (Nasdaq, VIX)
-- Date: 2026-04-22

/* 1. Create Macro Interaction Table
Integrating FX, Interest Rates, and Volatility metrics.
*/
CREATE TABLE IF NOT EXISTS JPY_Carry_Analysis (
    trade_date DATE PRIMARY KEY,
    usd_jpy_rate DECIMAL(10, 4),   -- JPY=X (Higher means Yen Weakness, Lower means Yen Strength)
    us_10y_yield DECIMAL(7, 4),    -- ^TNX (US 10-Year Treasury Yield)
    vix_index DECIMAL(7, 4),       -- ^VIX (Market Volatility/Fear Gauge)
    nasdaq_returns DECIMAL(7, 4)   -- QQQ Daily % Return
);

/* 2. Detecting the "Unwinding" Signal
Goal: Find days where the Yen strengthened significantly (Sudden Drop in USD/JPY) 
and measure the corresponding spike in VIX and drop in Nasdaq.
*/
SELECT 
    trade_date,
    usd_jpy_rate,
    vix_index,
    nasdaq_returns,
    -- Simple Risk-Off Indicator: Yen Strength + VIX Spike
    CASE 
        WHEN usd_jpy_rate < (SELECT AVG(usd_jpy_rate) FROM JPY_Carry_Analysis) 
             AND vix_index > 20 THEN 'High Risk-Off'
        ELSE 'Normal'
    END AS market_regime
FROM JPY_Carry_Analysis
ORDER BY trade_date DESC;
