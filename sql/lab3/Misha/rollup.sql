select sum(request_cost) as request_total_cost, extract(year from request_date) as request_year
from request
group by rollup (request_year)
order by request_year