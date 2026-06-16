
  
    

  create  table "f1_dbt_db"."public"."team_adjusted_results_with_bonus__dbt_tmp"
  
  
    as
  
  (
    SELECT 
    d.driverref AS "Driver name",
    c.constructorname AS "Team name",
    ar.raceid AS "Race ID", 
    ar.driverid AS "Driver ID", 
    ar.position AS "Position", 
    ar.fastestlaprank, 
    ar.modern_points, 
    COALESCE(pffl.bonus_points, 0) AS bonus_points -- Coalesce used to handle cases that return NULL. In this case for fastest lap time that don't reward points (only the #1 fastest lap per race gets awarded +1 points).
FROM "f1_dbt_db"."public"."adjusted_results" ar
LEFT JOIN "f1_dbt_db"."public"."points_for_fastest_lap" pffl ON ar.fastestlaprank = pffl.fastestlaprank
INNER JOIN "f1_dbt_db"."public"."drivers" d ON ar.driverid = d.driverid
INNER JOIN "f1_dbt_db"."public"."constructors" c on ar.constructorid = c.constructorid
  );
  