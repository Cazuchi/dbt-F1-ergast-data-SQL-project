
  
    

  create  table "f1_dbt_db"."public"."TeamStrategyAggregated__dbt_tmp"
  
  
    as
  
  (
    SELECT
    tsc."Year",
    tsc."Team name",
    tsc."Driver #1 name",
    ROUND(ABS(AVG(tsc."Driver #1 stint volatility trend")), 2) AS "ABS driver #1 stint volatility trend",
    tsc."Driver #2 name",
    ROUND(ABS(AVG(tsc."Driver #2 stint volatility trend")), 2) AS "ABS driver #2 stint volatility trend",
    AVG(tsc."Team/Drivers combo race counter")::INTEGER AS "Team/Drivers combo race counter"
FROM "f1_dbt_db"."public"."TeamStrategy" tsc
GROUP BY tsc."Year", tsc."Driver #1 name", tsc."Driver #2 name", tsc."Team name"
  );
  