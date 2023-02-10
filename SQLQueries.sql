
---- Overall average rating for all airlines
select  round(avg(r_inflightwifiservice),1) as wifiservice, round(avg(r_foodanddrink),1) as foodService, round(avg(r_seatcomfort),1) as seatComfort, round(avg(r_legroomservice),1) as legroomComfort,
round(avg(r_inflightservice),1) as inflightService, round(avg(r_cleanliness),1) as cleanliness,round(avg(r_checkinservice),1) as checkinService, round(avg(r_baggagehandling),1) as baggageService,
round(avg(r_onboardservice),1) as onboardService, round(avg(r_inflightentertainment),1) as entertainment, round(avg(r_onlineboarding),1) as boardingService, round(avg(r_easeofonlinebooking),1) as onlineService,
round(avg(r_gatelocation),1) as ontimereach, round(avg(r_departurearrivaltimeconvenient),1) as departurearrivaltimeconvenient
from customerdetails cust
inner join reviewdetails rev on  cust.c_custid = rev.r_custid;

----Overall average rating based on airlines
select cust.c_aircraftid, round(avg(r_inflightwifiservice),1) as wifiservice, round(avg(r_foodanddrink),1) as foodService, round(avg(r_seatcomfort),1) as seatComfort, round(avg(r_legroomservice),1) as legroomComfort,
round(avg(r_inflightservice),1) as inflightService, round(avg(r_cleanliness),1) as cleanliness,round(avg(r_checkinservice),1) as checkinService, round(avg(r_baggagehandling),1) as baggageService,
round(avg(r_onboardservice),1) as onboardService, round(avg(r_inflightentertainment),1) as entertainment, round(avg(r_onlineboarding),1) as boardingService, round(avg(r_easeofonlinebooking),1) as onlineService,
round(avg(r_gatelocation),1) as ontimereach, round(avg(r_departurearrivaltimeconvenient),1) as departurearrivaltimeconvenient
from customerdetails cust
inner join reviewdetails rev on  cust.c_custid = rev.r_custid
group by cust.c_aircraftid;

----Top 10 Airlines best performed on overallCategories
select * from(
select cust.c_aircraftid, round(avg(r_inflightwifiservice),1) as wifiservice, round(avg(r_foodanddrink),1) as foodService, round(avg(r_seatcomfort),1) as seatComfort, round(avg(r_legroomservice),1) as legroomComfort,
round(avg(r_inflightservice),1) as inflightService, round(avg(r_cleanliness),1) as cleanliness,round(avg(r_checkinservice),1) as checkinService, round(avg(r_baggagehandling),1) as baggageService,
round(avg(r_onboardservice),1) as onboardService, round(avg(r_inflightentertainment),1) as entertainment, round(avg(r_onlineboarding),1) as boardingService, round(avg(r_easeofonlinebooking),1) as onlineService,
round(avg(r_gatelocation),1) as ontimereach, round(avg(r_departurearrivaltimeconvenient),1) as departurearrivaltimeconvenient,
rank() over (order by round(avg(r_inflightwifiservice),1),round(avg(r_foodanddrink),1) , round(avg(r_seatcomfort),1) , round(avg(r_legroomservice),1) ,
round(avg(r_inflightservice),1) , round(avg(r_cleanliness),1) ,round(avg(r_checkinservice),1) , round(avg(r_baggagehandling),1) ,
round(avg(r_onboardservice),1) , round(avg(r_inflightentertainment),1) , round(avg(r_onlineboarding),1) , round(avg(r_easeofonlinebooking),1) ,
round(avg(r_gatelocation),1) , round(avg(r_departurearrivaltimeconvenient),1)   desc) as topList
from customerdetails cust
inner join reviewdetails rev on  cust.c_custid = rev.r_custid
group by cust.c_aircraftid 
) subQuery
where topList <= 10;

----Top 10 Airlines best performed on overallCategories based on vote eligible people
select * from(
select cust.c_aircraftid,  round(avg(r_inflightwifiservice),1) as wifiservice, round(avg(r_foodanddrink),1) as foodService, round(avg(r_seatcomfort),1) as seatComfort, round(avg(r_legroomservice),1) as legroomComfort,
round(avg(r_inflightservice),1) as inflightService, round(avg(r_cleanliness),1) as cleanliness,round(avg(r_checkinservice),1) as checkinService, round(avg(r_baggagehandling),1) as baggageService,
round(avg(r_onboardservice),1) as onboardService, round(avg(r_inflightentertainment),1) as entertainment, round(avg(r_onlineboarding),1) as boardingService, round(avg(r_easeofonlinebooking),1) as onlineService,
round(avg(r_gatelocation),1) as ontimereach, round(avg(r_departurearrivaltimeconvenient),1) as departurearrivaltimeconvenient,
rank() over (order by round(avg(r_inflightwifiservice),1),round(avg(r_foodanddrink),1) , round(avg(r_seatcomfort),1) , round(avg(r_legroomservice),1) ,
round(avg(r_inflightservice),1) , round(avg(r_cleanliness),1) ,round(avg(r_checkinservice),1) , round(avg(r_baggagehandling),1) ,
round(avg(r_onboardservice),1) , round(avg(r_inflightentertainment),1) , round(avg(r_onlineboarding),1) , round(avg(r_easeofonlinebooking),1) ,
round(avg(r_gatelocation),1) , round(avg(r_departurearrivaltimeconvenient),1)   desc) as topList
from customerdetails cust
inner join reviewdetails rev on  cust.c_custid = rev.r_custid
where cust.c_age >= 18
group by cust.c_aircraftid 
) subQuery
where topList <= 10;


--- overall satisfied and unsatisfied customers
select c_satisfaction, count(c_custid) as satisfaction from customerdetails
group by c_satisfaction;

---- no of satisfied customers based on airlines 
select  c_aircraftid, count(c_custid) as satisfied
from customerdetails
where c_satisfaction like 'satisfied%'
group by c_aircraftid
order by count(c_custid) desc;


---- no of unsatisfied customers based on airlines 
select  c_aircraftid, count(c_custid) unsatisfied
from customerdetails
where c_satisfaction like '%neutral%dissatisfied%'
group by c_aircraftid
order by count(c_custid) desc;

------- no of loyal customers based on airlines 
select  c_aircraftid, count(c_custid) as loyalCustomers
from customerdetails
where c_customertype like 'Loyal%'
group by c_aircraftid
order by count(c_custid) desc;


---- no of disloyal customers based on airlines 
select  c_aircraftid, count(c_custid) disloyalCustomers
from customerdetails
where c_customertype like '%disloyal%'
group by c_aircraftid
order by count(c_custid) desc;



--- best wifi service
select cust.c_aircraftid, round(avg(r_inflightwifiservice),1) as wifiservice,
rank() over (order by round(avg(r_inflightwifiservice),1) desc)
from customerdetails cust
inner join reviewdetails rev on  cust.c_custid = rev.r_custid
group by cust.c_aircraftid;

--- best food service
select cust.c_aircraftid, round(avg(r_foodanddrink),1) as foodService,
rank() over (order by round(avg(r_foodanddrink),1) desc)
from customerdetails cust
inner join reviewdetails rev on  cust.c_custid = rev.r_custid
group by cust.c_aircraftid;

--- best service in the flight by airline
select * from(
select cust.c_aircraftid, 
rank() over (order by round(avg(r_inflightwifiservice),1),round(avg(r_foodanddrink),1) , round(avg(r_seatcomfort),1) , round(avg(r_legroomservice),1) ,
round(avg(r_inflightservice),1) , round(avg(r_cleanliness),1) , round(avg(r_inflightentertainment),1) desc) as topList
from customerdetails cust
inner join reviewdetails rev on  cust.c_custid = rev.r_custid
group by cust.c_aircraftid 
) subQuery

----best service before flight journey
select * from(
select cust.c_aircraftid, 
rank() over (order by round(avg(r_checkinservice),1) , round(avg(r_baggagehandling),1) ,
round(avg(r_onboardservice),1) , round(avg(r_onlineboarding),1) , round(avg(r_easeofonlinebooking),1) ,
round(avg(r_gatelocation),1)  desc) as topList
from customerdetails cust
inner join reviewdetails rev on  cust.c_custid = rev.r_custid
group by cust.c_aircraftid 
) subQuery

---- top most seat comfort airlines
select * from(
select cust.c_aircraftid, 
rank() over (order by round(avg(r_seatcomfort),1) , round(avg(r_legroomservice),1) , round(avg(r_cleanliness),1) ,round(avg(r_checkinservice),1) , round(avg(r_baggagehandling),1) ,
round(avg(r_onboardservice),1) desc) as topList
from customerdetails cust
inner join reviewdetails rev on  cust.c_custid = rev.r_custid
group by cust.c_aircraftid 
) subQuery



