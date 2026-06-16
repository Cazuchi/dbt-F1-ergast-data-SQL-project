SELECT
    GREATEST(MAX(ABS(pt."Driver #1 rolling STDDEV")), MAX(ABS(pt."Driver #2 rolling STDDEV"))) AS "Rolling STDDEV max value",
    LEAST(MIN(ABS(pt."Driver #1 rolling STDDEV")), MIN(ABS(pt."Driver #2 rolling STDDEV"))) AS "Rolling STDDEV min value",
    GREATEST(MAX(ABS(pt."Driver #1 rolling STDDEV")), MAX(ABS(pt."Driver #2 rolling STDDEV")))
    -
    LEAST(MIN(ABS(pt."Driver #1 rolling STDDEV")), MIN(ABS(pt."Driver #2 rolling STDDEV")))
    AS "Rolling STDDEV width"
FROM "f1_dbt_db"."public"."pairs_table" pt