
  
    

  create  table "f1_dbt_db"."public"."team_final_output_table_filtered__dbt_tmp"
  
  
    as
  
  (
    SELECT
    fot."Team name",
    fot."Driver #1 name",
    fot."Driver #1 points",
    fot."Driver #1 rolling STDDEV",

    CASE 
    WHEN FIRST_VALUE(fot."Driver #1 rolling STDDEV") OVER stint_window_driver_1 IS NULL
    THEN LAST_VALUE(fot."Driver #1 rolling STDDEV") OVER stint_window_driver_1 - NTH_VALUE(fot."Driver #1 rolling STDDEV", 2) OVER stint_window_driver_1
    ELSE LAST_VALUE(fot."Driver #1 rolling STDDEV") OVER stint_window_driver_1 - FIRST_VALUE(fot."Driver #1 rolling STDDEV") OVER stint_window_driver_1
    END AS "Driver #1 stint volatility trend",

    CASE 
    WHEN fot."Driver #1 rolling STDDEV" <= fot."33th percentile" THEN 'Low volatility'
    WHEN fot."Driver #1 rolling STDDEV" <= fot."66th percentile" THEN 'Medium volatility'
    ELSE 'High volatility'
    END AS "Driver #1 volatility class",

    fot."Driver #2 name",
    fot."Driver #2 points",
    fot."Driver #2 rolling STDDEV",

    CASE 
    WHEN FIRST_VALUE(fot."Driver #2 rolling STDDEV") OVER stint_window_driver_2 IS NULL
    THEN LAST_VALUE(fot."Driver #2 rolling STDDEV") OVER stint_window_driver_2 - NTH_VALUE(fot."Driver #2 rolling STDDEV", 2) OVER stint_window_driver_2
    ELSE LAST_VALUE(fot."Driver #2 rolling STDDEV") OVER stint_window_driver_2 - FIRST_VALUE(fot."Driver #2 rolling STDDEV") OVER stint_window_driver_2
    END AS "Driver #2 stint volatility trend",

    CASE 
    WHEN fot."Driver #2 rolling STDDEV" <= fot."33th percentile" THEN 'Low volatility'
    WHEN fot."Driver #2 rolling STDDEV" <= fot."66th percentile" THEN 'Medium volatility'
    ELSE 'High volatility'
    END AS "Driver #2 volatility class",

    ABS(fot."Driver #1 rolling STDDEV" - fot."Driver #2 rolling STDDEV") AS "ABS difference between driver STDDEVs",
    fot."Race ID",
    rc.raceyear as "Year",
    fot."G&L distance measure",
    fot."Team/Drivers combo race counter"
FROM "f1_dbt_db"."public"."team_final_output_table" fot
LEFT JOIN "f1_dbt_db"."public"."races" rc ON fot."Race ID" = rc.raceid
WHERE fot."Team/Drivers combo race counter" >= 10
WINDOW 
    stint_window_driver_1 AS (
        PARTITION BY fot."Driver #1 name", fot."G&L distance measure"
        ORDER BY fot."Race ID" ASC
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ),
    stint_window_driver_2 AS (
        PARTITION BY fot."Driver #2 name", fot."G&L distance measure"
        ORDER BY fot."Race ID" ASC
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    )
  );
  