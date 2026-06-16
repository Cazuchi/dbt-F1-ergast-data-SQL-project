SELECT
    b1."Team name" AS "Team name",
    b1."Driver name" AS "Driver #1 name",
    b1."Points" AS "Driver #1 points",
    ROUND(STDDEV(b1."Points") OVER (PARTITION BY b1."Driver name" ORDER BY b1."Race ID" ASC), 2) AS "Driver #1 rolling STDDEV",
    b2."Driver name" AS "Driver #2 name",
    b2."Points" AS "Driver #2 points",
    ROUND(STDDEV(b2."Points") OVER (PARTITION BY b2."Driver name" ORDER BY b2."Race ID" ASC), 2) AS "Driver #2 rolling STDDEV",
    b1."Race ID" AS "Race ID",
    DENSE_RANK() OVER (ORDER BY b1."Race ID" ASC) AS "G&L main index",
    DENSE_RANK() OVER (PARTITION BY b1."Team name", b1."Driver name", b2."Driver name" ORDER BY b1."Race ID" ASC) AS "G&L specific index"
FROM "f1_dbt_db"."public"."base_table" b1
INNER JOIN "f1_dbt_db"."public"."base_table" b2
    ON b1."Team name" = b2."Team name"
    AND b1."Race ID" = b2."Race ID"
    AND b1."Driver name" < b2."Driver name"