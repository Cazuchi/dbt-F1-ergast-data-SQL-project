
  
    

  create  table "f1_dbt_db"."public"."career_points_table__dbt_tmp"
  
  
    as
  
  (
    SELECT
    d.driverref AS "Driver name",
    SUM(arwb.points) AS "Career points (legacy scoring)",
    SUM(arwb.modern_points) + sum(arwb.bonus_points) AS "Career points (modern scoring)",
    COUNT(DISTINCT arwb.raceid) AS "Races entered",
    ROUND(COUNT(DISTINCT arwb.raceid)::NUMERIC / COUNT(DISTINCT rc.raceyear), 2) AS "Races per year",
    ROUND(AVG(arwb.modern_points) + AVG(arwb.bonus_points), 2) AS "Avg. points per race",
    STDDEV(arwb.modern_points + arwb.bonus_points) AS "STDDEV",
    MIN(rc.raceyear) AS "First season",
    MAX(rc.raceyear) AS "Latest season",
    COUNT(DISTINCT rc.raceyear) AS "Years active in racing",
    ROUND((SUM(arwb.modern_points) + sum(arwb.bonus_points))::NUMERIC / COUNT(DISTINCT rc.raceyear), 2) AS "Avg. points per year active in racing",
    max_year.max_year - MAX(rc.raceyear) AS "Years since last active in a race",
    SUM(CASE WHEN arwb.position IS NULL THEN 1 ELSE 0 END) AS "Races with NULL finish",
    ROUND(SUM(CASE WHEN arwb.position IS NULL THEN 1 ELSE 0 END)::NUMERIC / COUNT(DISTINCT arwb.raceid) * 100, 2) AS "Percentage of races with NULL placement"
FROM "f1_dbt_db"."public"."driver_adjusted_results_with_bonus" arwb
INNER JOIN "f1_dbt_db"."public"."drivers" d ON arwb.driverid = d.driverid
INNER JOIN "f1_dbt_db"."public"."races" rc ON arwb.raceid = rc.raceid
CROSS JOIN "f1_dbt_db"."public"."max_year"
GROUP BY d.driverref, max_year.max_year
HAVING (SUM(arwb.modern_points) + sum(arwb.bonus_points)) >= 1000
  );
  