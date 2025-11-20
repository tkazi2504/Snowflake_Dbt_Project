WITH CTE AS(

select 
TO_TIMESTAMP(STARTED_AT) AS STARTED_AT,
DATE(TO_TIMESTAMP(STARTED_AT)) AS DATE_STARTED_AT,
HOUR(TO_TIMESTAMP(STARTED_AT)) AS HOUR_STARTED_AT,

    {{daytype('STARTED_AT')}},
    {{get_season('STARTED_AT')}},
    {{function1('STARTED_AT')}} as SEASON_TYPE
    
    
from {{ source('demo', 'bike') }}
where STARTED_AT != 'started_at'
)

select * FROM CTE