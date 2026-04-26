WITH source AS (
    SELECT * FROM {{ source('raw', 'MTA_RIDERSHIP') }}
)

SELECT
    TRY_TO_TIMESTAMP(TRANSIT_TIMESTAMP)    AS transit_timestamp,
    TRANSIT_MODE                           AS transit_mode,
    STATION_COMPLEX_ID                     AS station_complex_id,
    STATION_COMPLEX                        AS station_complex,
    BOROUGH                                AS borough,
    PAYMENT_METHOD                         AS payment_method,
    FARE_CLASS_CATEGORY                    AS fare_class_category,
    RIDERSHIP                              AS ridership,
    TRANSFERS                              AS transfers,
    LATITUDE                               AS latitude,
    LONGITUDE                              AS longitude
FROM source
WHERE TRANSIT_TIMESTAMP IS NOT NULL
  AND RIDERSHIP IS NOT NULL
