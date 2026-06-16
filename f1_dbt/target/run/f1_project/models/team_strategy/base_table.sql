
  
    

  create  table "f1_dbt_db"."public"."base_table__dbt_tmp"
  
  
    as
  
  (
    SELECT
    arwb."Team name",
    arwb."Driver name",
    arwb."Race ID",
    arwb.modern_points + arwb.bonus_points AS "Points"
FROM "f1_dbt_db"."public"."team_adjusted_results_with_bonus" arwb
  );
  