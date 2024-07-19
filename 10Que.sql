select * from iplballs ;
select 
create table deliveries (
id	int , 
inning int ,	
over int ,
ball int,	
batsman varchar ,
non_striker varchar ,
bowler	varchar ,
batsman_runs	int ,
extra_runs	int ,
total_runs	int , 
is_wicket int ,
dismissal_kind varchar ,
player_dismissed varchar ,
fielder varchar ,
extras_type	varchar ,
batting_team varchar ,
bowling_team varchar 
);

select * from deliveries ;

copy deliveries from 'C:\Program Files\PostgreSQL\16\data\Data-Resource\Data\IPL_Ball.csv' delimiter ',' csv header ;

select batting_team as team ,
sum ()

drop table deliveries_v02 ;

create table deliveries_v02 as
( select  * ,
case when total_runs >= 4 then 'Boundary' 
 when total_runs = 0 then 'dot' 
else 'other'
 end as 
ball_result 
from deliveries 
) ;

select * from deliveries_V02 ;

select batting_team as Team , count (ball_result ) as Total_boundaries 
from deliveries_v02 
where ball_result = 'Boundary' 
group by Team 
order by total_boundaries desc;


select bowling_team as team , count (ball_result ) total_dots 
from deliveries_v02 
where 
ball_result = 'dot'
group by team
order by total_dots desc ;

select count (dismissal_kind) as total_dismissal
from deliveries_v02
where not  dismissal_kind = 'NA' ;

select * from deliveries ;

select bowler ,  sum (extra_runs) as extras 
from 
deliveries 
group by bowler 
order by extras desc
limit 5;

select * from iplmatches ;

create table deliveries_v03 as 
select
a.*  ,
b.venue as venue ,
b.date as match_date 
from deliveries_v02 as a
inner join 
iplmatches as b
on 
a.id = b.id ;

select * from iplmatches ; 





select * from deliveries_v03 ;

select venue , sum (total_runs) as Total_runs_scored
from deliveries_v03
group by venue
order by  total_runs_scored desc ;

select  extract (year from match_date ) as Match_year , sum (total_runs) as runs_scored
from deliveries_v03 
where venue = 'Eden Gardens'
group by match_year
order  by sum(total_runs) desc ;