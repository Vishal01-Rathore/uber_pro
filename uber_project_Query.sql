/*SQL / POWER BI PROJECT QUESTIONS

Ride Booking Insights
1.	What is the total number of bookings?
2.	What is the percentage distribution of all ride statuses?
3.	How many average bookings were made per day?
4.	Which day of the week has the highest number of bookings?

Customer Insights
5.	Who are the top 5 customers based on the highest number of bookings?
6.	Who are the top 5 customers based on the highest total amount paid?

Vehicle and Ratings Analysis
7.	Which vehicle type is booked the most?
8.	Which vehicle type has the highest average driver rating?

Cancellation & Incomplete Ride Analysis
9.	What are the most common reasons for ride cancellations by customers?
10.	What is the most common reason for ride cancellations by drivers? 
11.	What is the most common reason for incomplete rides?

Location & Demand Analysis
12.	Which pickup location has the highest number of bookings?
13.	Which drop location is the most common?

Time-Based Analysis
14.	What are the peak hours for ride bookings?
15.	How does the number of bookings vary by weekday vs. weekend?
*/




--1.What is the total number of bookings?
CREATE VIEW total_number_of_bookings AS
SELECT COUNT(*) FROM FINAL_BOOKINGS;


--1.What is the total number of bookings?
SELECT * FROM total_number_of_bookings;



--2.What is the percentage distribution of all ride statuses?
CREATE VIEW percentage_distribution_of_all_ride_statuses AS
SELECT
     CASE    -- it is like conditional statements or if/else in python 
         WHEN BOOKING_STATUS IN ('Cancelled by Customer', 'Cancelled by Driver', 'Success', 'Incomplete')
        THEN BOOKING_STATUS
        ELSE 'Others'
    END AS BOOKING_STATUS_GROUPED,  
    COUNT (*) AS TOTAL_RIDES,
 ROUND (((COUNT (*) * 100/ (SELECT COUNT (*) FROM FINAL_BOOKINGS))),2) || '%'  AS AVERAGE_PERCENTAGE
        FROM FINAL_BOOKINGS 
       GROUP BY  BOOKING_STATUS_GROUPED
       ORDER BY TOTAL_RIDES DESC ;

--2.What is the percentage distribution of all ride statuses?
SELECT * FROM percentage_distribution_of_all_ride_statuses;



--3.How many average bookings were made per day?
CREATE VIEW average_bookings_were_made_per_day AS
SELECT ROUND(AVG(RIDES_BOOKED)) AS AVERAGE_BOOKINGS_MADE_PER_DAY
FROM (
    SELECT COUNT (*) AS RIDES_BOOKED, DATE
    FROM FINAL_BOOKINGS
   GROUP BY DATE 
  ORDER BY DATE ASC) AS DAILY_BOOKINGS;



--3.How many average bookings were made per day?
SELECT * FROM average_bookings_were_made_per_day;



--4.Which day of the week has the highest number of bookings?
CREATE VIEW day_of_the_week_with_the_highest_number_of_bookings AS
SELECT EXTRACT(ISODOW FROM DATE) AS WEEKDAY, TO_CHAR(DATE, 'DAY') AS WEEKDAY_NAME, COUNT(*) AS TOTAL_BOOKINGS
FROM FINAL_BOOKINGS
GROUP BY WEEKDAY, WEEKDAY_NAME
ORDER BY WEEKDAY DESC
LIMIT 1;


--4.Which day of the week has the highest number of bookings?
SELECT * FROM day_of_the_week_with_the_highest_number_of_bookings;


--5.Who are the top 5 customers based on the highest number of bookings?
CREATE VIEW top_5_customers_based_on_the_highest_number_of_bookings AS
SELECT COUNT (*) AS  TOTAL_BOOKINGS, CUSTOMER_ID
FROM FINAL_BOOKINGS
GROUP BY CUSTOMER_ID
ORDER BY TOTAL_BOOKINGS DESC
LIMIT 5;


--5.Who are the top 5 customers based on the highest number of bookings?
SELECT * FROM top_5_customers_based_on_the_highest_number_of_bookings;



--6.Who are the top 5 customers based on the highest total amount paid?
CREATE VIEW top_5_customers_based_on_the_highest_total_amount_paid AS
SELECT 
    CUSTOMER_ID, 
    SUM(COALESCE(BOOKING_VALUE, 0)) AS TOTAL_AMOUNT_PAID
FROM FINAL_BOOKINGS
GROUP BY CUSTOMER_ID
ORDER BY TOTAL_AMOUNT_PAID DESC
LIMIT 5;

--6.Who are the top 5 customers based on the highest total amount paid?
SELECT * FROM top_5_customers_based_on_the_highest_total_amount_paid;


--7.Which vehicle type is booked the most?
CREATE VIEW vehicle_type_booked_the_most AS
SELECT VEHICLE_TYPE, COUNT (*) AS NO_OF_RIDES_BOOKED_FOR_VEHICLE
FROM FINAL_BOOKINGS
GROUP BY VEHICLE_TYPE 
ORDER BY NO_OF_RIDES_BOOKED_FOR_VEHICLE DESC
LIMIT 1;

--7.Which vehicle type is booked the most?
SELECT * FROM vehicle_type_booked_the_most;


--8.Which vehicle type has the highest average driver rating?
CREATE VIEW vehicle_type_the_highest_average_driver_rating AS 
SELECT 
    VEHICLE_TYPE, 
    ROUND(CAST(AVG(DRIVER_RATING) AS NUMERIC), 3) AS AVERAGE_RATING
FROM FINAL_BOOKINGS
WHERE DRIVER_RATING IS NOT NULL  -- Exclude NULL ratings
GROUP BY VEHICLE_TYPE
ORDER BY AVERAGE_RATING DESC
LIMIT 1;

--8.Which vehicle type has the highest average driver rating?
SELECT * FROM vehicle_type_the_highest_average_driver_rating



--9.What are the most common reasons for ride cancellations by customers?
CREATE VIEW most_common_reasons_for_ride_cancellations_by_customers AS
SELECT REASON_FOR_CANCELLING_BY_CUSTOMER, COUNT (*)  AS RIDES_CANCELLED
FROM FINAL_BOOKINGS
WHERE REASON_FOR_CANCELLING_BY_CUSTOMER IS NOT NULL
GROUP BY REASON_FOR_CANCELLING_BY_CUSTOMER
ORDER BY RIDES_CANCELLED DESC
LIMIT 5;

--9.What are the most common reasons for ride cancellations by customers?
SELECT * FROM most_common_reasons_for_ride_cancellations_by_customers;


--10.What is the most common reason for ride cancellations by drivers?

CREATE VIEW  most_common_reason_for_ride_cancellations_by_drivers AS
SELECT REASON_FOR_CANCELLING_BY_DRIVER, COUNT (*)  AS RIDES_CANCELLED
FROM FINAL_BOOKINGS
WHERE REASON_FOR_CANCELLING_BY_DRIVER IS NOT NULL
GROUP BY REASON_FOR_CANCELLING_BY_DRIVER
ORDER BY RIDES_CANCELLED DESC
LIMIT 4;


--10.What is the most common reason for ride cancellations by drivers?
SELECT * FROM  most_common_reason_for_ride_cancellations_by_drivers;


--11.What is the most common reason for incomplete rides?
CREATE VIEW most_common_reason_for_incomplete_rides AS
SELECT INCOMPLETE_RIDES_REASON, COUNT (*) AS RIDES_CANCELLED
FROM FINAL_BOOKINGS
WHERE INCOMPLETE_RIDES_REASON IS NOT NULL
GROUP BY INCOMPLETE_RIDES_REASON
ORDER BY RIDES_CANCELLED DESC
LIMIT 5;


--11.What is the most common reason for incomplete rides?
SELECT * FROM most_common_reason_for_incomplete_rides;



--12.Which pickup location has the highest number of bookings?
CREATE VIEW pickup_location_has_the_highest_number_of_bookings AS 
SELECT PICKUP_LOCATION, COUNT(*) AS NO_OF_TIMES_PICKUP_LOCATION_CHOOSED 
FROM FINAL_BOOKINGS 
GROUP BY PICKUP_LOCATION 
ORDER BY NO_OF_TIMES_PICKUP_LOCATION_CHOOSED DESC
LIMIT 1;

--12.Which pickup location has the highest number of bookings?
SELECT * FROM pickup_location_has_the_highest_number_of_bookings;


--13.Which drop location is the most common?
CREATE VIEW drop_location_is_the_most_common AS
SELECT DROP_LOCATION, COUNT(*) AS NO_OF_TIMES_DROP_LOCATION_CHOOSED 
FROM FINAL_BOOKINGS 
GROUP BY DROP_LOCATION 
ORDER BY NO_OF_TIMES_DROP_LOCATION_CHOOSED DESC
LIMIT 1;


--13.Which drop location is the most common?
SELECT * FROM drop_location_is_the_most_common;



--14.What are the peak hours for ride bookings?
CREATE VIEW peak_hours_for_ride_bookings AS 
SELECT EXTRACT(HOUR FROM TIME) AS HOURS, COUNT(*) AS NO_OF_RIDES_BOOKED_AT_THIS_TIME
FROM FINAL_BOOKINGS 
GROUP BY HOURS
ORDER BY NO_OF_RIDES_BOOKED_AT_THIS_TIME DESC
LIMIT 3;

--14.What are the peak hours for ride bookings?
SELECT * FROM peak_hours_for_ride_bookings;



--15.How does the number of bookings vary by weekday vs. weekend?
CREATE VIEW number_of_bookings_vary_by_weekday_vs_weekend AS
SELECT EXTRACT(ISODOW FROM DATE) AS WEEKDAY, TO_CHAR(DATE, 'DAY') AS WEEKDAY_NAME, COUNT(*) AS TOTAL_BOOKINGS
FROM FINAL_BOOKINGS
GROUP BY WEEKDAY, WEEKDAY_NAME
ORDER BY WEEKDAY DESC;

--15.How does the number of bookings vary by weekday vs. weekend?
SELECT * FROM number_of_bookings_vary_by_weekday_vs_weekend;

