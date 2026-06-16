
  
    

  create  table "f1_dbt_db"."public"."final_output_table__dbt_tmp"
  
  
    as
  
  (
    SELECT
    cpt."Driver name",
    cpt."Career points (legacy scoring)",
    cpt."Career points (modern scoring)",
    cpt."Races entered",
    cpt."Races per year",
    cpt."Avg. points per race",
    ROUND(cpt."STDDEV", 2) AS "Standard deviation (~volatility)",

    CONCAT(
        '[', 
        GREATEST(0.00, ROUND(cpt."Avg. points per race" - cpt."STDDEV", 2)), 
        ' - ', 
        LEAST(25, ROUND(cpt."Avg. points per race" + cpt."STDDEV", 2)), 
        ']'
    ) AS "1 standard deviation for scored points",

    CONCAT(
        '[', 
        GREATEST(0.00, ROUND(cpt."Avg. points per race" - 2 * cpt."STDDEV", 2)), 
        ' - ', 
        LEAST(25, ROUND(cpt."Avg. points per race" + 2 * cpt."STDDEV", 2)), 
        ']'
    ) AS "2 standard deviation for scored points",

    cpt."First season",
    cpt."Latest season",
    cpt."Years active in racing",
    cpt."Avg. points per year active in racing",
    cpt."Years since last active in a race",
    cpt."Races with NULL finish",
    cpt."Percentage of races with NULL placement",
    1 AS "Sort by order"
FROM "f1_dbt_db"."public"."career_points_table" cpt
  );
  