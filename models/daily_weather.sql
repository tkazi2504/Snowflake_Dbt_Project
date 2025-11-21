{{ config(materialized='table') }}


WITH daily_weather AS(

    SELECT 
    DATE(TIME) as weather_date,
    DATE_FROM_PARTS(2023,EXTRACT(MONTH FROM weather_date),EXTRACT(DAY FROM weather_date)) AS weather_date2,
    weather,
    temp,
    pressure,
    humidity,
    clouds

    FROM {{ source('demo', 'weather') }}
),

daily_weather_Agg as (

    SELECT
    weather_date,
    weather_date2,
    weather,
    round(avg(temp),2) as avg_temp,
    round(avg(pressure),2) as avg_pressure,
    round(avg(humidity),2) as avg_humidity,
    round(avg(clouds),2) as avg_clouds,   
    row_number() over (partition by weather_date order by count(weather) desc) as rn
    from daily_weather
    group by weather_date,weather_date2,weather
    qualify rn = 1
)

select * from daily_weather_Agg
