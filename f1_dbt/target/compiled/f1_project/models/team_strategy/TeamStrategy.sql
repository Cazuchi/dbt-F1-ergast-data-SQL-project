SELECT
    fotf."Team name",

    CASE
    WHEN fotf."Driver #1 rolling STDDEV" < fotf."Driver #2 rolling STDDEV"
    THEN CONCAT(
        fotf."Driver #1 volatility class",
        ' / ',
        fotf."Driver #2 volatility class",
        ' driver pair'
    ) 
    ELSE CONCAT(
        fotf."Driver #2 volatility class",
        ' / ',
        fotf."Driver #1 volatility class",
        ' driver pair'
    ) 
    END AS "Team driver pairing strategy",
    
    fotf."Driver #1 name",
    fotf."Driver #1 points",
    fotf."Driver #1 rolling STDDEV",
    fotf."Driver #1 stint volatility trend",
    fotf."Driver #1 volatility class",
    fotf."Driver #2 name",
    fotf."Driver #2 points",
    fotf."Driver #2 rolling STDDEV",
    fotf."Driver #2 stint volatility trend",
    fotf."Driver #2 volatility class",
    fotf."ABS difference between driver STDDEVs",
    fotf."Race ID",
    fotf."Year",
    fotf."G&L distance measure",
    fotf."Team/Drivers combo race counter"
FROM "f1_dbt_db"."public"."team_final_output_table_filtered" fotf