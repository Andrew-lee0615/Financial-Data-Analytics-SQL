/* [Task] Analyze Customer Order Volume and Segment Top Tier Clients
   [Goal] Identify key markets for strategic acquisition analysis */

SELECT 
    Country, 
    COUNT(CustomerID) AS Total_Clients,
    CASE 
        WHEN COUNT(CustomerID) >= 10 THEN 'Tier 1 (Priority)'
        WHEN COUNT(CustomerID) >= 5 THEN 'Tier 2 (Active)'
        ELSE 'Tier 3 (Potential)'
    END AS Market_Priority
FROM Customers
GROUP BY Country
HAVING COUNT(CustomerID) > 1
ORDER BY Total_Clients DESC;
