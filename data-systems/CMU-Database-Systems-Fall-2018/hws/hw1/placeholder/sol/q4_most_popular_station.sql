with visit(station_id, station_name, city, cnt) as (select station_id, station_name, city, count(id) as cnt from trip, station where station_id = start_station_id or station_id = end_station_id group by station_id)
select visit.city, visit.station_name, visit.cnt from visit where visit.cnt = (select max(cnt) from visit as max_visit where max_visit.city = visit.city) order by city;
