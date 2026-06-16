
  
    

  create  table "f1_dbt_db"."public"."adjusted_results__dbt_tmp"
  
  
    as
  
  (
    SELECT 
    r.raceid, 
    r.driverid, 
    r.constructorid, 
    r.points, 
    r.position, 
    r.fastestlaprank, 
    COALESCE(mps.modern_points, 0) AS modern_points -- Coalesce used to handle cases that return NULL. In this case when a position does NOT reward any points.
FROM "f1_dbt_db"."public"."results" r
LEFT JOIN "f1_dbt_db"."public"."modern_points_system"  mps ON r.position = mps.position
  );
  