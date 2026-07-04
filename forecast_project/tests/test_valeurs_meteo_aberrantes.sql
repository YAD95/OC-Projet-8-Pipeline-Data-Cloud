-- test_valeurs_meteo_aberrantes.sql
-- Ce test centralise toutes les vérifications physiques des relevés météo.

SELECT 
    station_id,
    observation_timestamp,
    temperature,
    humidity,
    wind_speed
FROM {{ ref('fct_weather_readings') }}
WHERE temperature < -50 OR temperature > 60
   OR humidity < 0 OR humidity > 100
   OR wind_speed < 0