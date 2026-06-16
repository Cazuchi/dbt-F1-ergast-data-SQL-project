SELECT 
    d.driverref AS "Driver name",
    c.constructorname AS "Team name",
    ar.raceid AS "Race ID", 
    ar.driverid AS "Driver ID", 
    ar.position AS "Position", 
    ar.fastestlaprank, 
    ar.modern_points, 
    COALESCE(pffl.bonus_points, 0) AS bonus_points -- Coalesce used to handle cases that return NULL. In this case for fastest lap time that don't reward points (only the #1 fastest lap per race gets awarded +1 points).
FROM {{ ref('adjusted_results') }} ar
LEFT JOIN {{ ref('points_for_fastest_lap') }} pffl ON ar.fastestlaprank = pffl.fastestlaprank
INNER JOIN {{ source('f1', 'drivers') }} d ON ar.driverid = d.driverid
INNER JOIN {{ source('f1', 'constructors') }} c on ar.constructorid = c.constructorid