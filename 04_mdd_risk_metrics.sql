Step 04: Historical Risk Assessment via Maximum Drawdown (MDD)
================================================================================
[Background]
Following the Step 03 'Tariff Impact Simulation', it is crucial to determine 
if the current price drop triggered by macro shocks is within a historically 
normal range or an extraordinary oversold condition.

[Objective]
1. Calculate the 'Running Maximum' price for each ticker.
2. Compute the daily 'Drawdown' percentage from the peak.
3. Identify the 'Maximum Drawdown (MDD)' to establish a risk benchmark.

[Key Concept]
MDD is a key metric in NYC risk management to measure the worst-case loss 
scenario from a peak to a trough before a new peak is attained.
================================================================================
*/

-- 1. Create a Common Table Expression (CTE) for Price Metrics
WITH PriceMetrics AS (
    SELECT 
        date,
        ticker,
        adj_close,
        -- Calculate the peak price up to the current date (Running Max)
        MAX(adj_close) OVER (
            PARTITION BY ticker 
            ORDER BY date 
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) as running_max
    FROM stock_prices
),

-- 2. Calculate daily drawdown
DrawdownCalc AS (
    SELECT 
        date,
        ticker,
        adj_close,
        running_max,
        -- Formula: (Current Price - Peak Price) / Peak Price
        (adj_close - running_max) / running_max as drawdown
    FROM PriceMetrics
)

-- 3. Final Output: MDD per Ticker
SELECT 
    ticker,
    ROUND(MIN(drawdown) * 100, 2) as mdd_percentage, -- The worst-case drop
    MIN(date) as analysis_start,
    MAX(date) as analysis_end
FROM DrawdownCalc
GROUP BY ticker
ORDER BY mdd_percentage ASC;

/*
[Analysis Note for NYC Interview]
"By quantifying MDD using SQL window functions, I can objectively compare 
current market volatility with a decade of historical data, providing a 
statistical basis for 'buy-on-dip' strategies or risk mitigation."
*/
