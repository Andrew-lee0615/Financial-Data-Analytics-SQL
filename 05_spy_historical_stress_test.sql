Focus: Stress Testing SPY during GFC (2008) & COVID-19 (2020)
  Logic: Using Window Functions to calculate 5-day SMA and flagging 3% daily drops.
*/

WITH DailyMarketData AS (
    SELECT 
        Date,
        Adj_Close,
        Volume,
        -- Calculate 5-Day Simple Moving Average (SMA) to track short-term trend
        AVG(Adj_Close) OVER (ORDER BY Date ROWS BETWEEN 4 PRECEDING AND CURRENT ROW) AS SMA_5,
        -- Retrieve previous day's closing price to calculate daily returns
        LAG(Adj_Close) OVER (ORDER BY Date) AS Prev_Close
    FROM 
        SPY_Prices
    WHERE 
        (Date BETWEEN '2008-01-01' AND '2009-12-31') -- GFC Era
        OR 
        (Date BETWEEN '2020-01-01' AND '2020-06-30') -- COVID Shock
)
SELECT 
    Date,
    Adj_Close,
    SMA_5,
    -- Calculate Daily Return Percentage (Precision: 2 decimal places)
    ROUND(((Adj_Close - Prev_Close) / Prev_Close) * 100, 2) AS Daily_Return_Pct,
    -- Risk Labeling: Identify days with extreme sell-offs (>3% drop)
    CASE 
        WHEN ((Adj_Close - Prev_Close) / Prev_Close) <= -0.03 THEN 'CRASH'
        ELSE 'NORMAL'
    END AS Risk_Signal
FROM 
    DailyMarketData
ORDER BY 
    Date;
