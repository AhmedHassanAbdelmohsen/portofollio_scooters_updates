--Define data

select carId,lon,lat,mileage,city,vehicleStateId,isReserved,isDamaged,damageDescription,fuelLevel,timeLastPositionUpdate,updateTime from [electric scooters ]..scooters$

--create a new table with defined data for data visualiztion 

create view importantcolumns as 
select carId,lon,lat,mileage,city,vehicleStateId,isReserved,isDamaged,damageDescription,fuelLevel,timeLastPositionUpdate,updateTime 
from [electric scooters ]..scooters$

select * from importantcolumns

-- defines number of scooters on each location 

select city,count(carId) as scooterpercity   from scooters$
group by city 
order by scooterpercity  asc

--damaged scooters percity 
select city,count(carId) as scooterpercity    from scooters$
where damageDescription is not null
group by city 
order by scooterpercity desc

--major issues in damaged scooters 

select distinct damageDescription ,count(carId) as totalscoo     from scooters$
where damageDescription is not null 
group by damageDescription
order by totalscoo desc



--showing total scooters that fuel between 31 to 49

select city,count(carId)as totalscoo
from scooters$
where fuelLevel > 30 and fuelLevel< 50
group by city
order by city asc

--showing total scooters that fuel between 31 to 49
select city,count(carId)as totalscoo
from scooters$
where fuelLevel >= 15 and fuelLevel< 31
group by city
order by city asc

--showing all scooters per city where fuel levels less than 15 that are not damaged 

select city,count(carId)as totalscoo
from scooters$
where fuelLevel <15 and damageDescription is null 
group by city
order by city asc

--showing total scooters per city that are more than 50 fuel level 

select city,count(carId)as totalscoo
from scooters$
where fuelLevel >50 
group by city
order by city asc


-- showing low battery scos that are below 30 and not in main

select city,count(carId)as totalscoo
from scooters$
where fuelLevel <30  and damageDescription is null
group by city
order by city asc

--how many scooters on each fuel level based on city 
select city,fuelLevel,count(carId)
from scooters$
where city is not null 
group by fuelLevel,city
order by city asc


create view columntime as 
select city,carId,damageDescription,timeLastPositionUpdate,SYSDATETIME() as nowda
from [electric scooters ]..scooters$
group by city,carId,damageDescription,timeLastPositionUpdate
order by timeLastPositionUpdate desc


--showing period of last moved scooters 
select city,carId,damageDescription,min(timeLastPositionUpdate) as lastmoved 
from [electric scooters ]..scooters$
group by city,carId,damageDescription
order by 1,2

--total of scooters not moved since long time 

select city,carId,damageDescription,min(timeLastPositionUpdate) as lastmoved 
from [electric scooters ]..scooters$
group by city,carId,damageDescription
order by 1,2

--showing scooters that did not give update since long time 
select city,carId,damageDescription,min(updateTime) as noupdate
from [electric scooters ]..scooters$
--where updateTime < '2020-03-05 07:33:56'
group by city,carId,damageDescription
order by noupdate asc


select city,carId,damageDescription,min(updateTime) as noupdate,(SYSDATETIME()- convert(datetime,updatetime)) as differ
from [electric scooters ]..scooters$
--where updateTime < '2020-03-05 07:33:56'
group by city,carId,damageDescription
order by noupdate asc

select city,carId,damageDescription,min(updateTime) as noupdate,(updateTime-timeLastMoved) as differ
from [electric scooters ]..scooters$
group by city,carId,damageDescription


----------------------
--show the scooters that did not move since long time or did not get update  

select   city,carId,fuelLevel,timeLastMoved,updateTime , DATEDIFF(day,updateTime,SYSDATETIME()) as lasttimeupdateperhour ,DATEDIFF(day,timeLastPositionUpdate,SYSDATETIME()) as lasttimemovedperhours 
from scooters$
--group by carId
order by lasttimemovedperhours desc
----------------------------------
















