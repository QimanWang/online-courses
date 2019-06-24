select city, count(station_id) as cnt from station group by city order by cnt asc, city asc;
