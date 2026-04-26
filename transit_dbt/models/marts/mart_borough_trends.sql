WITH daily AS (
    SELECT * FROM {{ ref('int_daily_ridership') }}
)

SELECT
    transit_date,
    borough,
    SUM(total_ridership)                   AS daily_ridership,
    SUM(total_transfers)                   AS daily_transfers
FROM daily
GROUP BY 1, 2
ORDER BY 1, 2
