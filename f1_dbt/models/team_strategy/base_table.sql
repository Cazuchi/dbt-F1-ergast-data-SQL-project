SELECT
    arwb."Team name",
    arwb."Driver name",
    arwb."Race ID",
    arwb.modern_points + arwb.bonus_points AS "Points"
FROM {{ ref('team_adjusted_results_with_bonus') }} arwb