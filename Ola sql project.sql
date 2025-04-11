create database ola;
use ola;
DROP DATABASE ola;

#1. Retrieve all successful bookings:
create view successful_bookings AS
SELECT * FROM bookings WHERE booking_status = 'success';
select * from successful_bookings;

#2. Find the average ride distance for each vehicle type:
create view average_ride_distance AS
select Vehicle_Type, AVG(Ride_distance)
AS avg_distance from bookings 
group by Vehicle_Type;
select * from average_ride_distance;

#3. Get the total number of cancelled rides by customers:
create view cancelled_rides_by_customer as
select count(*) from bookings where booking_status = 'cancelled by customer';
select * from cancelled_rides_by_customer;

#4. List the top 5 customers who booked the highest number of rides:
create view top_5_customers as
SELECT Customer_ID, COUNT(Booking_ID) as total_rides FROM bookings GROUP BY
Customer_ID ORDER BY total_rides DESC LIMIT 5;
select * from top_5_customers;

#5. Get the number of rides cancelled by drivers due to personal and car-related issues:
create view  Rides_cancelled_by_Drivers_P_C_Issues As
SELECT COUNT(*) FROM bookings WHERE cancelled_Rides_by_Driver = 'Personal & Car related issue';
select * from Rides_cancelled_by_Drivers_P_C_Issues;

#6. Find the maximum and minimum driver ratings for Prime Sedan bookings:
Create View Max_Min_Driver_Rating As
SELECT MAX(Driver_Ratings) as max_rating,
MIN(Driver_Ratings) as min_rating
FROM bookings WHERE Vehicle_Type = 'Prime Sedan';
select * from Max_Min_Driver_Rating;

#7. Retrieve all rides where payment was made using UPI:
Create View UPI_Payment As
SELECT * FROM bookings
WHERE Payment_Method = 'UPI';
select * from UPI_Payment;

#8. Find the average customer rating per vehicle type:
create view avg_customer_rating as
SELECT Vehicle_Type, AVG(Customer_Rating) as avg_customer_rating FROM bookings
GROUP BY Vehicle_Type;
select * from avg_customer_rating;

#9. Calculate the total booking value of rides completed successfully:
create view total_successful_ride_value As  
SELECT SUM(Booking_Value) as total_successful_value FROM bookings WHERE
Booking_Status = 'Success';
select * from total_successful_ride_value;

#10. List all incomplete rides along with the reason:
Create View Incomplete_Rides_Reason As
SELECT Booking_ID, Incomplete_Rides_Reason
FROM bookings
WHERE Incomplete_Rides = 'Yes';
select * from Incomplete_Rides_Reason;
