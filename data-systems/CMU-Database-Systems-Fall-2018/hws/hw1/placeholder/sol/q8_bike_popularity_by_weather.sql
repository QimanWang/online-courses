with weather_days(events, cnt) as (
    select w.events, count(distinct w.date) as cnt from weather w group by w.events
)
select w.events, round(cast(count(distinct t.id) as float)/cast(wd.cnt as float), 4) as avg from trip t, station s, weather w, weather_days wd
where t.start_station_id = s.station_id and s.zip_code = w.zip_code and date(t.start_time) = w.date and w.events = wd.events
group by w.events
order by avg desc, w.events asc;
