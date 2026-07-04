{{
    config(
        materialized='table',
        indexes=[
            {'columns': ['station_id'], 'unique': True}
        ]
    )
}}

WITH infoclimat_stations AS (
    SELECT
        station_id,
        station_name,
        station_type,
        latitude,
        longitude,
        elevation
    FROM {{ ref('stg_source_1_stations') }}
),

amateur_stations AS (
    -- On crée la station de La Madeleine avec les infos du PDF
    SELECT
        'STA_MADELEINE' AS station_id,
        'La Madeleine' AS station_name,
        'amateur' AS station_type,
        50.659 AS latitude,
        3.07 AS longitude,
        23 AS elevation
        
    UNION ALL
    
    -- On crée la station d'Ichtegem avec les infos du PDF
    SELECT
        'STA_STATION_3' AS station_id,
        'WeerstationBS' AS station_name,
        'amateur' AS station_type,
        51.092 AS latitude,
        2.999 AS longitude,
        15 AS elevation
)

SELECT * FROM infoclimat_stations
UNION ALL
SELECT * FROM amateur_stations