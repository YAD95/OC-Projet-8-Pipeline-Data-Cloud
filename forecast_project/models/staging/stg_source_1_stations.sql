WITH raw_data AS (
    SELECT stations
    FROM {{ source('airbyte_raw', 'source_1_raw') }}
),

flattened_stations AS (
    SELECT DISTINCT
        -- On extrait les infos et on force le bon format
        (station_element->>'id')::varchar AS station_id,
        (station_element->>'name')::varchar AS station_name,
        (station_element->>'type')::varchar AS station_type,
        (station_element->>'latitude')::numeric AS latitude,
        (station_element->>'longitude')::numeric AS longitude,
        (station_element->>'elevation')::integer AS elevation
    FROM raw_data,
    -- On déroule la liste JSON
    jsonb_array_elements(stations) AS station_element
)

SELECT * FROM flattened_stations