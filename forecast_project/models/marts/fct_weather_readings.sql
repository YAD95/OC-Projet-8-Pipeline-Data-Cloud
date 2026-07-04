{{
    config(
        materialized='table',
        indexes=[
            {'columns': ['station_id']},
            {'columns': ['observation_timestamp']}
        ]
    )
}}

WITH final_facts AS (
    SELECT * 
    FROM {{ ref('int_weather_data_unioned') }}
    -- On supprime les lignes fantômes (vides) remontées par Airbyte
    WHERE station_id IS NOT NULL 
      AND observation_timestamp IS NOT NULL
)

SELECT DISTINCT * FROM final_facts