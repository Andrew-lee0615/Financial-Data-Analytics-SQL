-- Project 07: Energy Shock Segmentation & Sector Spread Analysis
-- Context: Analyzing the 'Alpha Decoupling' caused by LNG supply-side shocks.
-- Date: 2026-04-21

/* 1. Create Table for Sector Returns
Storing daily percentage changes for Natural Gas and key sector ETFs.
*/
CREATE TABLE IF NOT EXISTS Daily_Sector_Returns (
    trade_date DATE PRIMARY KEY,
    gas_price_returns DECIMAL(7, 4),      -- Natural Gas ($NG=F) daily % change
    energy_sector_returns DECIMAL(7, 4),  -- XLE (Energy) daily % change
    industrial_sector_returns DECIMAL(7, 4), -- XLI (Industrials) daily % change
    event_desc VARCHAR(100)               -- Qualitative notes
);

/* 2. Identify "Supply-Side Shock" & Calculate Spread
Goal: Find days where Gas jumped >5% and measure the XLE vs. XLI performance gap.
*/
SELECT 
    trade_date,
    gas_price_returns,
    energy_sector_returns,
    industrial_sector_returns,
    -- Positive spread means Energy outperformed Industrials
    (energy_sector_returns - industrial_sector_returns) AS sector_spread 
FROM Daily_Sector_Returns
WHERE gas_price_returns >= 0.05 
ORDER BY sector_spread DESC;
