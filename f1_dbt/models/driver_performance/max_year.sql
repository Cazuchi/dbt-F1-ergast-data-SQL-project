SELECT 
    MAX(raceyear) as max_year
FROM {{ source('f1', 'races') }}