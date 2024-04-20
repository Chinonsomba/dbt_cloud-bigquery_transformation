with
    customerdata as (
        select distinct
            u.id as user_id,
            sum(case when u.gender = 'F' then 1 else null end) as female,
            sum(case when u.gender = 'M' then 1 else null end) as male,
            u.country as country
        from {{ ref("stgorderitems") }} as o
        inner join {{ ref("stgUsers") }} u on o.user_id = u.id
        where o.status not in ('Cancelled', 'Returned')
        group by 1, 4
    )

select
    country,
    count(distinct user_id) as customers_count,
    count(female) as female,
    count(male) as male
from customerdata
group by country
order by customers_count desc