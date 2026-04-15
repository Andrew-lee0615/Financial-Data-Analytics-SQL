/* [Simulation] Impact of Tariff Hikes on Sector Profitability
Scenario: Estimating margin compression based on a 15.1%p increase in average US tariff rates.
Data Source: Based on NYU Stern Industry Average Margins (2025/2026)
*/

SELECT 
    Sector,
    Avg_Margin_Before AS "Current_Margin_Pct",
    (Avg_Margin_Before - 15.1) AS "Projected_Margin_Pct",
    CASE 
        WHEN (Avg_Margin_Before - 15.1) < 0 THEN 'CRITICAL (Net Loss)'
        WHEN (Avg_Margin_Before - 15.1) < 10 THEN 'WARNING (Low Margin)'
        ELSE 'STABLE'
    END AS Risk_Assessment
FROM (
    -- Real-world industry margins for simulation
    SELECT 'Retail (General)' AS Sector, 6.2 AS Avg_Margin_Before UNION
    SELECT 'Automotive' AS Sector, 8.5 AS Avg_Margin_Before UNION
    SELECT 'Consumer Electronics' AS Sector, 12.4 AS Avg_Margin_Before UNION
    SELECT 'Semiconductors' AS Sector, 28.7 AS Avg_Margin_Before UNION
    SELECT 'Software (System)' AS Sector, 42.0 AS Avg_Margin_Before
) AS Market_Analysis
ORDER BY "Projected_Margin_Pct" ASC;
