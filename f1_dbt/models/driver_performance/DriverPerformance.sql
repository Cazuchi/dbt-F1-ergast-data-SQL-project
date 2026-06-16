SELECT * FROM {{ ref('final_output_table') }}
UNION ALL
SELECT
    'Subtotals row (averages)',
    ROUND(AVG("Career points (legacy scoring)"), 0),
    ROUND(AVG("Career points (modern scoring)"), 0),
    ROUND(AVG("Races entered"), 0),
    ROUND(AVG("Races per year"), 2),
    ROUND(AVG("Avg. points per race"), 2),
    ROUND(AVG("Standard deviation (~volatility)"), 2),
    NULL,
    NULL,
    NULL,
    NULL,
    ROUND(AVG("Years active in racing"), 0),
    ROUND(AVG("Avg. points per year active in racing"), 2),
    ROUND(AVG("Years since last active in a race"), 0),
    ROUND(AVG("Races with NULL finish"), 0),
    ROUND(AVG("Percentage of races with NULL placement"), 2),
    2
FROM {{ ref('final_output_table') }}