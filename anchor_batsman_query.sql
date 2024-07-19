select  * from iplballs 

create table iplmatches (
id int ,
date date ) ;

select * from iplmatches ;

 copy iplmatches from 'C:\Program Files\PostgreSQL\16\data\Data-Resource\Data\IPL_matches.csv' delimiter ',' csv header ;
 
 select * from iplmatches ;
 
 create table batsman as 
 (  select 
 a.id ,
 a.batsman,
 a.batsman_runs,
 a.is_wicket ,
 b.date 
 from 
 iplballs as a 
 inner join 
 iplmatches as b
 on 
 a.id =b.id  );
 
 select * from batsman ;
 
 
 SELECT 
    batsman,
    SUM(batsman_runs) AS total_runs,
    EXTRACT(YEAR FROM MAX(date)) - EXTRACT(YEAR FROM MIN(date)) AS seasons_played,
    (SUM(batsman_runs) / COUNT(CASE WHEN is_wicket = '1' THEN 1 ELSE NULL END)) AS average,
    COUNT(CASE WHEN is_wicket = '1' THEN 1 ELSE NULL END) AS dismissed
FROM 
    batsman
GROUP BY 
    batsman
HAVING 
    EXTRACT(YEAR FROM MAX(date)) - EXTRACT(YEAR FROM MIN(date)) > 2 
    AND COUNT(CASE WHEN is_wicket = '1' THEN 1 ELSE NULL END) > 1
ORDER BY 
    average DESC
	limit 10 ;