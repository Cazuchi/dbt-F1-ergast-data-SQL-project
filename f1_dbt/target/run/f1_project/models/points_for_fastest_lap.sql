
  
    

  create  table "f1_dbt_db"."public"."points_for_fastest_lap__dbt_tmp"
  
  
    as
  
  (
    SELECT fastestlaprank, bonus_points
FROM (VALUES
    (1, 1)
) AS t(fastestlaprank, bonus_points)
  );
  