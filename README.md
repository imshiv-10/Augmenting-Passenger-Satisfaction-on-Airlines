# Augmenting-Passenger-Satisfaction-on-Airlines


> # Project Motive

The main motive is to design a database management system for airlines to provide enhanced
experience to every passenger who are on board. Airlines with the help of SQL queries will gain
valuable insights from the dataset and strive to improve customer satisfaction.

This project will give us the opportunity to test the following concepts learned in class:
• Designing Entity Relationship (ER) models on a real-world dataset.
• Translating ER diagrams into SQL schema.
• Developing proper and enhanced SQL queries.
• Measuring the performance of a SQL query
• Query Optimization


# Attached Files

• Raw dataset (csv format): raw_data.zip
• Data transformation/cleaning: clean.py, clean.ipynb
• Transformed dataset (csv format): transformed_data.zip
• DDL statements: ddl_schema.sql
• DML statements: dml.sql
• SQL queries + code for experiments: SQLQueries.sql

# Dataset

selected our airlines database from Kaggle, based on our entity relational model we are dividing
data into multiple datasets.
https://www.kaggle.com/datasets/teejmahal20/airline-passenger-satisfaction

** CustomerDetails**

1. custID int
2. Gender text
3. CustomerType text
4. Age int
5. TypeofTravel text
6. Flight Distance int
7. DepartureDelayinMinutes text
8. ArrivalDelayinMinutes text
9. satisfaction text
10.AircraftID text
ReviewInfo
1. custID int
2. Inflightwifiservice text
3. DepartureArrivaltimeconvenient text
4. EaseofOnlinebooking text
5. Gatelocation text
6. Foodanddrink text
7. Onlineboarding text
8. Seatcomfort text
9. Inflightentertainment text
10.Onboardservice text
11.Legroomservice text
12.Baggagehandling text
13.Checkinservice text
14.Inflightservice text
15.Cleanliness text

**AircraftInfo**

1. AircraftID text
2. Company text

#### Description of Dataset:

Gender: Gender of the passengers (Female, Male)
Customer Type: The customer type (Loyal customer, disloyal customer)
Age: The actual age of the passengers
Type of Travel: Purpose of the flight of the passengers (Personal Travel, Business Travel)
Class: Travel class in the plane of the passengers (Business, Eco, Eco Plus)
Flight distance: The flight distance of this journey
Inflight wifi service: Satisfaction level of the inflight wifi service (0:Not Applicable;1-5)
Departure/Arrival time convenient: Satisfaction level of Departure/Arrival time convenient
Ease of Online booking: Satisfaction level of online booking
Gate location: Satisfaction level of Gate location
Food and drink: Satisfaction level of Food and drink
Online boarding: Satisfaction level of online boarding
Seat comfort: Satisfaction level of Seat comfort
Inflight entertainment: Satisfaction level of inflight entertainment
On-board service: Satisfaction level of On-board service
Leg room service: Satisfaction level of Leg room service
Baggage handling: Satisfaction level of baggage handling
Check-in service: Satisfaction level of Check-in service
Inflight service: Satisfaction level of inflight service
Cleanliness: Satisfaction level of Cleanliness
Departure Delay in Minutes: Minutes delayed when departure
Arrival Delay in Minutes: Minutes delayed when Arrival
Satisfaction: Airline satisfaction level (Satisfaction, neutral or dissatisfaction)
AircraftID: Unique identification of Airline
Company: Name of Airline

# Conceptual Design

The ER diagram below provides a faithful, complete and unambiguous specification of the datastored in
airlines dataset.

Database Schema
We converted the above conceptual design into the following SQL schema:
DROP TABLE IF EXISTS part aircraftDetails;
DROP TABLE IF EXISTS region customerDetails;
DROP TABLE IF EXISTS nation reviewInfo;
Create table aircraftDetails
(
a_AircraftID CHAR(25),
a_Company varchar(250),
PRIMARY KEY(a_AircraftID)
);
Create table customerDetails
(
c_custID INT PRIMARY KEY,
c_gender CHAR(10),
c_customerType CHAR(25),
c_age INTEGER,
c_ TypeofTravel CHAR(25),
c_ FlightDistance INTEGER,
c_ DepartureDelayinMinutes CHAR(25),
c_ ArrivalDelayinMinutes CHAR(25),
c_ satisfaction VARCHAR (50),
c_AircraftID CHAR(25),
CONSTRAINT fk_aircraftID FOREIGN KEY(c_AircraftID)
REFERENCES aircraftDetails(a_AircraftID)
);
Create table reviewDetails
(
r_custID INT,
r_Inflightwifiservice CHAR(10),
r_DepartureArrivaltimeconvenient CHAR(10),
r_EaseofOnlinebooking CHAR(10),
r_Gatelocation CHAR(10),
r_Foodanddrink CHAR(10),
r_Onlineboarding CHAR(10),
r_Seatcomfort CHAR(10),
r_Inflightentertainment CHAR(10),
r_Onboardservice CHAR(10),
r_Legroomservice CHAR(10),
r_Baggagehandling CHAR(10),
r_Checkinservice CHAR(10),
r_Inflightservice CHAR(10),
r_Cleanliness CHAR(10),
CONSTRAINT fk_customerID FOREIGN KEY(c_custID)
REFERENCES customerDetails(c_custID)
);

# Data Preprocessing

Cleaning is a very important part of analysis process.
We began this series on data analysis by presenting the following summary of the analysis process:
• We will pull the raw data from CSV file or database, then make any adjustments to the data with
our python script.
• Instead, with PostgresSQL, we can write a query to do the cleaning once and then store the results
in a table.

# Data Analysis Lifecycle

Data cleaning is crucial to create accurate and meaningful models.
• The DepartureDelayinMinutes and ArrivalDelayinMinutes is seen as a text data type which
will cause various issues.
• The Review Info every column must be in the form of integer format otherwise it leads to a
problem.
• Aircraft and CustID formats needs to be match with the customerDetails key fields.
We need to do some data refactoring on our raw table due to data types. We noticed that
DepartureDelayinMinutes and ArrivalDelayinMinutes columns text and ReviewInfo all columns are
recorded as a text data type. We need to convert text columns to a timestamp and the ReviewInfo all fields
to integer.

# PostgresSQL code

We want to change the datatype of my reviewinfo columns from text to integer. Again, this is
straightforward in PostgresSQL with astype(int) function.

# Data Cleaning:

Loading raw data into the python platform
• customerDetails = pd.read_csv("raw_customerDetails.csv")
• reviewInfo = pd.read_csv("raw_reviewInfo.csv")
• aircraftDetails = pd.read_csv("raw_aircraftDetails.csv")
converting the text data to the minutes format
• customerDetails['c_ArrivalDelayinMinutes'] =
pd.to_datetime(customerDetails['c_ArrivalDelayinMinutes'],unit='m').dt.strftime('%H:%M')
• customerDetails['c_DepartureDelayinMinutes'] =
pd.to_datetime(customerDetails['c_DepartureDelayinMinutes'], unit='m').dt.strftime('%H:%M')
converting the text data to numeric format
• reviewInfo['r_Inflightservice'] =reviewInfo['r_Inflightservice'].astype(int)
• reviewInfo['r_DepartureArrivaltimeconvenient']
=reviewInfo['r_DepartureArrivaltimeconvenient'].astype(int)
• reviewInfo['r_EaseofOnlinebooking'] =reviewInfo['r_EaseofOnlinebooking'].astype(int)
• reviewInfo['r_Gatelocation'] =reviewInfo['r_Gatelocation'].astype(int)
• reviewInfo['r_Foodanddrink'] =reviewInfo['r_Foodanddrink'].astype(int)
• reviewInfo['r_Onlineboarding'] =reviewInfo['r_Onlineboarding'].astype(int)
• reviewInfo['r_Seatcomfort'] =reviewInfo['r_Seatcomfort'].astype(int)
• reviewInfo['r_Inflightentertainment'] =reviewInfo['r_Inflightentertainment'].astype(int)
• reviewInfo['r_Onboardservice'] =reviewInfo['r_Onboardservice'].astype(int)
• reviewInfo['r_Legroomservice'] =reviewInfo['r_Legroomservice'].astype(int)
• reviewInfo['r_Baggagehandling'] =reviewInfo['r_Baggagehandling'].astype(int)
• reviewInfo['r_Checkinservice'] =reviewInfo['r_Checkinservice'].astype(int)
• reviewInfo['r_Inflightwifiservice'] =reviewInfo['r_Inflightwifiservice'].astype(int)
• reviewInfo['r_Cleanliness'] =reviewInfo['r_Cleanliness'].astype(int)
checking the data types of key constraint fields, if there are any disturbances on datatype mismatch below
statements will convert to desired uniform data types.
• if customerDetails['c_custID'].dtype != reviewInfo['r_custID'].dtype:
• customerDetails['c_custID'] = customerDetails['c_custID'].astype(int)
• reviewInfo['r_custID'] =reviewInfo['r_custID'].astype(int)
• if customerDetails['c_AircraftID'].dtype != aircraftDetails['a_AircraftID'].dtype:
• customerDetails['c_AircraftID'] = customerDetails['c_AircraftID'].astype(str)
• aircraftDetails['a_AircraftID'] = aircraftDetails['a_AircraftID'].astype(str)
Storing the final transformed dataframe to the CSV format.
• customerDetails.to_csv('customerDetails.csv', index= True)
• reviewInfo.to_csv('reviewInfo.csv', index= True)
• aircraftDetails.to_csv('aircraftDetails.csv', index= True)

# DML Statements

We populated our schema with the following DML statements:
• copy aircraftDetails FROM ''/Users/shiva/Desktop/aircraftDetails.csv/' DELIMITER ',' CSV
HEADER;
• copy customerDetails FROM ''/Users/shiva/Desktop/DBMS-Project/customerDetails.csv'
DELIMITER ',' CSV HEADER;
• copy reviewInfo FROM ''/Users/shiva/Desktop/DBMS-Project/reviewInfo.csv' DELIMITER ',' CSV
HEADER;

# Methodology:

`---- Overall average rating for all airlines

select round(avg(r_inflightwifiservice),1) as wifiservice, round(avg(r_foodanddrink),1) as foodService,
round(avg(r_seatcomfort),1) as seatComfort, round(avg(r_legroomservice),1) as legroomComfort,
round(avg(r_inflightservice),1) as inflightService, round(avg(cleanliness),1) as
cleanliness,round(avg(r_checkinservice),1) as checkinService, round(avg(r_baggagehandling),1) as
baggageService,
round(avg(r_onboardservice),1) as onboardService, round(avg(r_inflightentertainment),1) as
entertainment, round(avg(r_onlineboarding),1) as boardingService, round(avg(r_easeofonlinebooking),1)
as onlineService,
round(avg(r_gatelocation),1) as ontimereach, round(avg(r_departurearrivaltimeconvenient),1) as
departurearrivaltimeconvenient
from customerdetails cust
inner join reviewdetails rev on cust.c_custid = rev.r_custid;


----Overall average rating based on airlines

select cust.c_aircraftid, round(avg(r_inflightwifiservice),1) as wifiservice, round(avg(r_foodanddrink),1)
as foodService, round(avg(r_seatcomfort),1) as seatComfort, round(avg(r_legroomservice),1) as
legroomComfort,
round(avg(r_inflightservice),1) as inflightService, round(avg(r_cleanliness),1) as
cleanliness,round(avg(r_checkinservice),1) as checkinService, round(avg(r_baggagehandling),1) as
baggageService,
round(avg(r_onboardservice),1) as onboardService, round(avg(r_inflightentertainment),1) as
entertainment, round(avg(r_onlineboarding),1) as boardingService, round(avg(r_easeofonlinebooking),1)
as onlineService,
round(avg(r_gatelocation),1) as ontimereach, round(avg(r_departurearrivaltimeconvenient),1) as
departurearrivaltimeconvenient
from customerdetails cust
inner join reviewdetails rev on cust.c_custid = rev.r_custid
group by cust.c_aircraftid;



----Top 10 Airlines best performed on overallCategories

select * from(
select cust.c_aircraftid, round(avg(r_inflightwifiservice),1) as wifiservice, round(avg(r_foodanddrink),1)
as foodService, round(avg(r_seatcomfort),1) as seatComfort, round(avg(r_legroomservice),1) as
legroomComfort,
round(avg(r_inflightservice),1) as inflightService, round(avg(r_cleanliness),1) as
cleanliness,round(avg(r_checkinservice),1) as checkinService, round(avg(r_baggagehandling),1) as
baggageService,
round(avg(r_onboardservice),1) as onboardService, round(avg(r_inflightentertainment),1) as
entertainment, round(avg(r_onlineboarding),1) as boardingService, round(avg(r_easeofonlinebooking),1)
as onlineService,
round(avg(r_gatelocation),1) as ontimereach, round(avg(r_departurearrivaltimeconvenient),1) as
departurearrivaltimeconvenient,
rank() over (order by round(avg(r_inflightwifiservice),1),round(avg(r_foodanddrink),1) ,
round(avg(r_seatcomfort),1) , round(avg(r_legroomservice),1) ,
round(avg(r_inflightservice),1) , round(avg(r_cleanliness),1) ,round(avg(r_checkinservice),1) ,
round(avg(r_baggagehandling),1) ,
round(avg(r_onboardservice),1) , round(avg(r_inflightentertainment),1) , round(avg(r_onlineboarding),1)
, round(avg(r_easeofonlinebooking),1) ,
round(avg(r_gatelocation),1) , round(avg(r_departurearrivaltimeconvenient),1) desc) as topList
from customerdetails cust
inner join reviewdetails rev on cust.c_custid = rev.r_custid
group by cust.c_aircraftid
) subQuery
where topList <= 10;



----Top 10 Airlines best performed on overallCategories based on vote eligible people

select * from(
select cust.c_aircraftid, round(avg(r_inflightwifiservice),1) as wifiservice, round(avg(r_foodanddrink),1)
as foodService, round(avg(r_seatcomfort),1) as seatComfort, round(avg(r_legroomservice),1) as
legroomComfort,
round(avg(r_inflightservice),1) as inflightService, round(avg(r_cleanliness),1) as
cleanliness,round(avg(r_checkinservice),1) as checkinService, round(avg(r_baggagehandling),1) as
baggageService,
round(avg(r_onboardservice),1) as onboardService, round(avg(r_inflightentertainment),1) as
entertainment, round(avg(r_onlineboarding),1) as boardingService, round(avg(r_easeofonlinebooking),1)
as onlineService,
round(avg(r_gatelocation),1) as ontimereach, round(avg(r_departurearrivaltimeconvenient),1) as
departurearrivaltimeconvenient,
rank() over (order by round(avg(r_inflightwifiservice),1),round(avg(r_foodanddrink),1) ,
round(avg(r_seatcomfort),1) , round(avg(r_legroomservice),1) ,
round(avg(r_inflightservice),1) , round(avg(r_cleanliness),1) ,round(avg(r_checkinservice),1) ,
round(avg(r_baggagehandling),1) ,
round(avg(r_onboardservice),1) , round(avg(r_inflightentertainment),1) , round(avg(r_onlineboarding),1)
, round(avg(r_easeofonlinebooking),1) ,
round(avg(r_gatelocation),1) , round(avg(r_departurearrivaltimeconvenient),1) desc) as topList
from customerdetails cust
inner join reviewdetails rev on cust.c_custid = rev.r_custid
where cust.c_age >= 18
group by cust.c_aircraftid
) subQuery
where topList <= 10;



--- overall satisfied and unsatisfied customers


select c_satisfaction, count(c_custid) as satisfaction from customerdetails
group by c_satisfaction;


---- no of satisfied customers based on airlines
select c_aircraftid, count(c_custid) as satisfied
from customerdetails
where c_satisfaction like 'satisfied%'
group by c_aircraftid
order by count(c_custid) desc;

---- no of unsatisfied customers based on airlines
select c_aircraftid, count(c_custid) unsatisfied
from customerdetails
where c_satisfaction like '%neutral%dissatisfied%'
group by c_aircraftid
order by count(c_custid) desc;

------- no of loyal customers based on airlines
select c_aircraftid, count(c_custid) as loyalCustomers
from customerdetails
where c_customertype like 'Loyal%'
group by c_aircraftid
order by count(c_custid) desc;

---- no of disloyal customers based on airlines
select c_aircraftid, count(c_custid) disloyalCustomers
from customerdetails
where c_customertype like '%disloyal%'
group by c_aircraftid
order by count(c_custid) desc;

--- best wifi service
select cust.c_aircraftid, round(avg(r_inflightwifiservice),1) as wifiservice,
rank() over (order by round(avg(r_inflightwifiservice),1) desc)
from customerdetails cust
inner join reviewdetails rev on cust.c_custid = rev.r_custid
group by cust.c_aircraftid;

--- best food service
select cust.c_aircraftid, round(avg(r_foodanddrink),1) as foodService,
rank() over (order by round(avg(r_foodanddrink),1) desc)
from customerdetails cust
inner join reviewdetails rev on cust.c_custid = rev.r_custid
group by cust.c_aircraftid;

--- best service in the flight by airline

select * from(
select cust.c_aircraftid,
rank() over (order by round(avg(r_inflightwifiservice),1),round(avg(r_foodanddrink),1) ,
round(avg(r_seatcomfort),1) , round(avg(r_legroomservice),1) ,
round(avg(r_inflightservice),1) , round(avg(r_cleanliness),1) , round(avg(r_inflightentertainment),1) desc)
as topList
from customerdetails cust
inner join reviewdetails rev on cust.c_custid = rev.r_custid
group by cust.c_aircraftid
) subQuery

----best service before flight journey

select * from(
select cust.c_aircraftid,
rank() over (order by round(avg(r_checkinservice),1) , round(avg(r_baggagehandling),1) ,
round(avg(r_onboardservice),1) , round(avg(r_onlineboarding),1) , round(avg(r_easeofonlinebooking),1)
,
round(avg(r_gatelocation),1) desc) as topList
from customerdetails cust
inner join reviewdetails rev on cust.c_custid = rev.r_custid
group by cust.c_aircraftid
) subQuery

---- top most seat comfort airlines

select * from(
select cust.c_aircraftid,
rank() over (order by round(avg(r_seatcomfort),1) , round(avg(r_legroomservice),1) ,
round(avg(r_cleanliness),1) ,round(avg(r_checkinservice),1) , round(avg(r_baggagehandling),1) ,
round(avg(r_onboardservice),1) desc) as topList
from customerdetails cust
inner join reviewdetails rev on cust.c_custid = rev.r_custid
group by cust.c_aircraftid
) subQuery`

# Final Conclusion:

Based on our analysis, we concluded that there are various factors passengers consider while rating their
travel experience with the airline, keeping in view of all those factors and evaluating them we came up with
various relational databases techniques to find best airline. Using our relational model Airlines can evaluate
their performance and work in a way to improve their service.
