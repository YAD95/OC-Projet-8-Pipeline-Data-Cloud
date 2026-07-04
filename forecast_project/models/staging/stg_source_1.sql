WITH raw_data AS (
    SELECT hourly
    FROM {{ source('airbyte_raw', 'source_1_raw') }}
),

flattened_data AS (
    SELECT 
        -- Extraction des champs texte et conversion (cast) dans le bon format
        (reading->>'id_station')::varchar AS station_id,
        (reading->>'dh_utc')::timestamp AS observation_date,
        (reading->>'temperature')::numeric AS temperature,
        (reading->>'humidite')::numeric AS humidity,
        (reading->>'pression')::numeric AS pressure,
        (reading->>'vent_moyen')::numeric AS wind_speed,
        (reading->>'vent_rafales')::numeric AS wind_gust,
        (reading->>'vent_direction')::integer AS wind_direction,
        (reading->>'pluie_1h')::numeric AS rain_1h,
        (reading->>'pluie_3h')::numeric AS rain_3h,
        (reading->>'point_de_rosee')::numeric AS dew_point

    FROM raw_data,
    -- C'est ici que la magie Postgres opère pour aplatir le JSON
    jsonb_each(hourly) AS station(key, val),
    jsonb_array_elements(station.val) AS reading
)

SELECT * FROM flattened_data