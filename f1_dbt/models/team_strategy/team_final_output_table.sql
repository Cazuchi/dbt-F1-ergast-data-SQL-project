SELECT
    git."Team name",
    git."Driver #1 name",
    git."Driver #1 points",
    git."Driver #1 rolling STDDEV",
    git."Driver #2 name",
    git."Driver #2 points",
    git."Driver #2 rolling STDDEV",
    git."Rolling STDDEV width" * 0.33 + git."Rolling STDDEV min value" AS "33th percentile",
    git."Rolling STDDEV width" * 0.66 + git."Rolling STDDEV min value" AS "66th percentile",
    git."Race ID",
    git."G&L distance measure",
    COUNT(*) OVER (PARTITION BY git."Team name", git."Driver #1 name", git."Driver #2 name", git."G&L distance measure") AS "Team/Drivers combo race counter"
FROM {{ ref('gaps_and_islands_table') }} git