SELECT
    pt."Team name",
    pt."Driver #1 name",
    pt."Driver #1 points",
    pt."Driver #1 rolling STDDEV",
    pt."Driver #2 name",
    pt."Driver #2 points",
    pt."Driver #2 rolling STDDEV",
    pm."Rolling STDDEV max value" AS "Rolling STDDEV max value",
    pm."Rolling STDDEV min value" AS "Rolling STDDEV min value",
    pm."Rolling STDDEV width" AS "Rolling STDDEV width",
    pt."Race ID",
    pt."G&L main index",
    pt."G&L specific index",
    pt."G&L main index" - pt."G&L specific index" AS "G&L distance measure"
FROM "f1_dbt_db"."public"."pairs_table" pt
CROSS JOIN "f1_dbt_db"."public"."percentile_metrics" pm