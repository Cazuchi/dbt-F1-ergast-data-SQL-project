SELECT 
    ar.raceid, 
    ar.driverid, 
    ar.points, 
    ar.position, 
    ar.fastestlaprank, 
    ar.modern_points, 
    COALESCE(pffl.bonus_points, 0) as bonus_points -- Coalesce used to handle cases that return NULL. In this case for fastest lap time that don't reward points (only the #1 fastest lap per race gets awarded +1 points).
FROM "f1_dbt_db"."public"."adjusted_results" ar
LEFT JOIN "f1_dbt_db"."public"."points_for_fastest_lap" pffl ON ar.fastestlaprank = pffl.fastestlaprank