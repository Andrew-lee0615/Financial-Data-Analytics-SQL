/*
  Project: Financial Data Analytics
  Topic: Fundamental Data Extraction & Filtering
  Description: 
    - Replicating Excel's 'Filter' and 'Sort' functions using SQL.
    - Aiming to extract high-yield assets and sort them by risk profile for preliminary review.
*/

-- 1. Retrieve a unique list of sectors in the investment universe
-- Equivalent to Excel's 'Remove Duplicates' feature
SELECT DISTINCT sector 
FROM global_portfolio;

-- 2. Extract active technology assets with a return rate greater than 5%
-- Equivalent to Excel's 'Filter' feature
SELECT 
    ticker, 
    asset_name, 
    return_rate, 
    risk_score,
    last_valuation_date
FROM asset_universe
WHERE return_rate > 5 
  AND sector = 'Technology'
  AND status = 'Active'
-- Sort by highest returns and then by lowest risk score
ORDER BY return_rate DESC, risk_score ASC;

-- [Step 3] Advanced Filtering: Pattern Matching
-- Scenario: Finding all assets with tickers starting with 'A' (e.g., AAPL, AMZN)
-- Or searching for funds that contain 'ESG' in their name.

SELECT ticker, asset_name, sector
FROM asset_universe
WHERE ticker LIKE 'A%' 
   OR asset_name LIKE '%ESG%';
