SELECT 
    r.raceid, 
    r.driverid, 
    r.constructorid, 
    r.points, 
    r.position, 
    r.fastestlaprank, 
    COALESCE(mps.modern_points, 0) AS modern_points -- Coalesce used to handle cases that return NULL. In this case when a position does NOT reward any points.
FROM {{ source('f1', 'results') }} r
LEFT JOIN {{ ref('modern_points_system') }}  mps ON r.position = mps.position