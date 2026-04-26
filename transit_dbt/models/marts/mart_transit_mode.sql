WITH daily AS (
    SELECT * FROM {{ ref('int_daily_ridership') }}
)

SELECT
    transit_mode,
    SUM(total_ridership)                   AS total_ridership,
    ROUND(AVG(total_ridership), 2)         AS avg_daily_ridership,
    COUNT(DISTINCT transit_date)           AS days_active
FROM daily
GROUP BY 1
ORDER BY total_ridership DESC
