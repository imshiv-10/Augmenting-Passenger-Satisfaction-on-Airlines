import numpy as np
import pandas as pd

customerDetails = pd.read_csv("raw_customerDetails.csv")
reviewInfo = pd.read_csv("raw_reviewInfo.csv")
aircraftDetails = pd.read_csv("raw_aircraftDetails.csv")

customerDetails['c_ArrivalDelayinMinutes'] = pd.to_datetime(customerDetails['c_ArrivalDelayinMinutes'],unit='m').dt.strftime('%H:%M')

customerDetails['c_DepartureDelayinMinutes'] = pd.to_datetime(customerDetails['c_DepartureDelayinMinutes'],unit='m').dt.strftime('%H:%M')


reviewInfo['r_Inflightservice'] =reviewInfo['r_Inflightservice'].astype(int)
reviewInfo['r_DepartureArrivaltimeconvenient'] =reviewInfo['r_DepartureArrivaltimeconvenient'].astype(int)
reviewInfo['r_EaseofOnlinebooking'] =reviewInfo['r_EaseofOnlinebooking'].astype(int)
reviewInfo['r_Gatelocation'] =reviewInfo['r_Gatelocation'].astype(int)
reviewInfo['r_Foodanddrink'] =reviewInfo['r_Foodanddrink'].astype(int)
reviewInfo['r_Onlineboarding'] =reviewInfo['r_Onlineboarding'].astype(int)
reviewInfo['r_Seatcomfort'] =reviewInfo['r_Seatcomfort'].astype(int)
reviewInfo['r_Inflightentertainment'] =reviewInfo['r_Inflightentertainment'].astype(int)
reviewInfo['r_Onboardservice'] =reviewInfo['r_Onboardservice'].astype(int)
reviewInfo['r_Legroomservice'] =reviewInfo['r_Legroomservice'].astype(int)
reviewInfo['r_Baggagehandling'] =reviewInfo['r_Baggagehandling'].astype(int)
reviewInfo['r_Checkinservice'] =reviewInfo['r_Checkinservice'].astype(int)
reviewInfo['r_Inflightwifiservice'] =reviewInfo['r_Inflightwifiservice'].astype(int)
reviewInfo['r_Cleanliness'] =reviewInfo['r_Cleanliness'].astype(int)


if customerDetails['c_custID'].dtype != reviewInfo['r_custID'].dtype:
    customerDetails['c_custID'] = customerDetails['c_custID'].astype(int)
    reviewInfo['r_custID'] =reviewInfo['r_custID'].astype(int)

if customerDetails['c_AircraftID'].dtype != aircraftDetails['a_AircraftID'].dtype:
    customerDetails['c_AircraftID'] = customerDetails['c_AircraftID'].astype(str)
    aircraftDetails['a_AircraftID'] = aircraftDetails['a_AircraftID'].astype(str)


customerDetails.to_csv('customerDetails.csv', index= True)
reviewInfo.to_csv('reviewInfo.csv', index= True)
aircraftDetails.to_csv('aircraftDetails.csv', index= True)


