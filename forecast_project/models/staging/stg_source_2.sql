WITH raw_data AS (
    SELECT *
    FROM {{ source('airbyte_raw', 'source_2_raw') }}
),

cleaned_data AS (
    SELECT 
        -- 1. On identifie manuellement cette station
        'STA_MADELEINE' AS station_id,
        
        -- 2. On garde l'heure de l'observation
        "Time"::time AS observation_time, 
        
        -- 3. Température : Extraction des chiffres purs + conversion Fahrenheit -> Celsius
        ROUND((SUBSTRING("Temperature" FROM '[-0-9.]+')::numeric - 32) * 5.0/9.0, 1) AS temperature,
        
        -- 4. Humidité : Extraction des chiffres purs
        SUBSTRING("Humidity" FROM '[-0-9.]+')::numeric AS humidity,
        
        -- 5. Pression : Extraction + conversion inHg -> hPa
        ROUND(SUBSTRING("Pressure" FROM '[-0-9.]+')::numeric * 33.8639, 1) AS pressure,
        
        -- 6. Vent : Extraction + conversion mph -> km/h
        ROUND(SUBSTRING("Speed" FROM '[-0-9.]+')::numeric * 1.60934, 1) AS wind_speed,
        ROUND(SUBSTRING("Gust" FROM '[-0-9.]+')::numeric * 1.60934, 1) AS wind_gust,
        
        -- 7. Point de rosée : Extraction + conversion Fahrenheit -> Celsius
        ROUND((SUBSTRING("Dew_Point" FROM '[-0-9.]+')::numeric - 32) * 5.0/9.0, 1) AS dew_point
        
    FROM raw_data
)

SELECT * FROM cleaned_data