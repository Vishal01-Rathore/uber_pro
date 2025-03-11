CREATE TABLE final_bookings(
    Date date NOT NULL,
    Time time NOT NULL,
    Booking_ID Varchar(20) NOT NULL primary key,
    Booking_Status Varchar(60),
    Customer_ID Varchar(20) NOT NULL,
    Vehicle_type Varchar(40) NOT NULL,
    Pickup_Location Varchar(100) NOT NULL,
    Drop_Location Varchar(100) NOT NULL,
    Avg_Vtat Float,
    Avg_Ctat Float,
    Reason_for_Cancelling_by_Customer Varchar(100),
    Reason_for_Cancelling_by_Driver Varchar(100),
    Incomplete_Rides_Reason Varchar(100),
    Booking_Value Float,
    Ride_Distance Float,
    Driver_Rating Float,
    Customer_Rating Float
    )