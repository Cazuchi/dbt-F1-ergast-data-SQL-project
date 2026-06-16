
  
    

  create  table "f1_dbt_db"."public"."max_year__dbt_tmp"
  
  
    as
  
  (
    SELECT 
    MAX(raceyear) as max_year
FROM "f1_dbt_db"."public"."races"
  );
  