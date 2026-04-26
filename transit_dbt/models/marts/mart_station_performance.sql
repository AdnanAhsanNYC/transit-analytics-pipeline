WITH daily AS (
    SELECT * FROM {{ ref('int_daily_ridership') }}
)

SELECT
    station_complex_id,
    station_complex,
    borough,
    AVG(latitude)                          AS latitude,
    AVG(longitude)                         AS longitude,
    SUM(total_ridership)                   AS total_ridership,
    SUM(total_transfers)                   AS total_transfers,
    COUNT(DISTINCT transit_date)           AS days_active,
    ROUND(AVG(total_ridership), 2)         AS avg_daily_ridership
FROM daily
GROUP BY 1, 2, 3
ORDER BY total_ridership DESC
