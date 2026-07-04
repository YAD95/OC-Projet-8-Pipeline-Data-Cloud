WITH source_1 AS (
    SELECT
        station_id,
        observation_date AS observation_timestamp,
        temperature,
        humidity,
        pressure,
        wind_speed,
        wind_gust,
        wind_direction,
        rain_1h,
        rain_3h,
        dew_point
    -- On utilise ref() pour appeler nos modèles de staging, pas les sources brutes !
    FROM {{ ref('stg_source_1') }}
),

source_2 AS (
    SELECT
        station_id,
        -- On fabrique un vrai timestamp en additionnant la date du jour et l'heure
        CURRENT_DATE + observation_time AS observation_timestamp,
        temperature,
        humidity,
        pressure,
        wind_speed,
        wind_gust,
        -- On crée des colonnes vides pour correspondre à la source 1
        NULL::integer AS wind_direction,
        NULL::numeric AS rain_1h,
        NULL::numeric AS rain_3h,
        dew_point
    FROM {{ ref('stg_source_2') }}
),

source_3 AS (
    SELECT
        station_id,
        CURRENT_DATE + observation_time AS observation_timestamp,
        temperature,
        humidity,
        pressure,
        wind_speed,
        wind_gust,
        NULL::integer AS wind_direction,
        NULL::numeric AS rain_1h,
        NULL::numeric AS rain_3h,
        dew_point
    FROM {{ ref('stg_source_3') }}
)

-- On empile le tout !
SELECT * FROM source_1
UNION ALL
SELECT * FROM source_2
UNION ALL
SELECT * FROM source_3