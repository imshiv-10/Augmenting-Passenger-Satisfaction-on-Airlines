DROP TABLE IF EXISTS aircraftDetails;
DROP TABLE IF EXISTS customerDetails;
DROP TABLE IF EXISTS reviewInfo;

Create table aircraftDetails
(
a_AircraftID CHAR(25), 
a_Company varchar(250),
PRIMARY KEY(a_AircraftID)
);

Create table customerDetails
(
c_custID INT PRIMARY KEY,
c_gender CHAR(25),
c_customerType CHAR(25),
c_age INTEGER,
c_TypeofTravel CHAR(25),
c_FlightDistance INTEGER,
c_DepartureDelayinMinutes time,
c_ArrivalDelayinMinutes time,
c_satisfaction VARCHAR (50),
c_AircraftID CHAR(25),
CONSTRAINT fk_aircraftID FOREIGN KEY(c_AircraftID) 
REFERENCES aircraftDetails(a_AircraftID)
);

Create table reviewDetails
(
r_custID INT,
r_Inflightwifiservice INT,
r_DepartureArrivaltimeconvenient INT,
r_EaseofOnlinebooking INT,
r_Gatelocation INT,
r_Foodanddrink INT,
r_Onlineboarding INT,
r_Seatcomfort INT,
r_Inflightentertainment INT,
r_Onboardservice INT,
r_Legroomservice INT,
r_Baggagehandling INT,
r_Checkinservice INT,
r_Inflightservice INT,
r_Cleanliness INT,
CONSTRAINT fk_customerID FOREIGN KEY(r_custID) 
REFERENCES customerDetails(c_custID)
);

