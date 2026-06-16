
  
    

  create  table "f1_dbt_db"."public"."modern_points_system__dbt_tmp"
  
  
    as
  
  (
    SELECT position, modern_points
FROM (VALUES
    (1, 25),
    (2, 18),
    (3, 15),
    (4, 12),
    (5, 10),
    (6, 8),
    (7, 6),
    (8, 4),
    (9, 2),
    (10, 1)
) AS t(position, modern_points)
  );
  