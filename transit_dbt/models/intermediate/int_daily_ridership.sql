WITH staging AS (
    SELECT * FROM {{ ref('stg_mta_ridership') }}
)

SELECT
    DATE_TRUNC('day', transit_timestamp)   AS transit_date,
    transit_mode,
    station_complex_id,
    station_complex,
    borough,
    SUM(ridership)                         AS total_ridership,
    SUM(transfers)                         AS total_transfers,
    COUNT(*)                               AS record_count,
    AVG(latitude)                          AS latitude,
    AVG(longitude)                         AS longitude
FROM staging
GROUP BY 1, 2, 3, 4, 5
