--query for table creation

CREATE TABLE hotel2019 (
	hotel VARCHAR,
    is_canceled INTEGER,
    lead_time INTEGER,
    arrival_date_year INTEGER,
	arrival_date_month INTEGER,
	arrival_date_week_number INTEGER,
	arrival_date_day_of_month VARCHAR,
	stays_in_weekend_nights INTEGER,
	stays_in_week_nights INTEGER,
	adults INTEGER,
	children INTEGER,
	babies INTEGER,
	meal VARCHAR(10),
	country VARCHAR(10),
	market_segment VARCHAR(20),
	distribution_channel VARCHAR(20),
	is_repeated_guest INTEGER,
	previous_cancellations INTEGER,
	previous_bookings_not_canceled INTEGER,
	reserved_room_type CHAR,
	assigned_room_type CHAR,
	booking_changes INTEGER,
	deposit_type VARCHAR(20),
	agent INTEGER,
	company INTEGER,
	days_in_waiting_list INTEGER,
	customer_type VARCHAR,
	adr INTEGER,
	required_car_parking_spaces INTEGER,
	total_of_special_requests INTEGER,
	reservation_status VARCHAR(20),
	reservation_status_date DATE
);

SELECT * from hotel2019

ALTER TABLE hotel2019 
ALTER COLUMN arrival_date_day_of_month TYPE INTEGER USING arrival_date_day_of_month::integer,
ALTER COLUMN arrival_date_month TYPE VARCHAR,
ALTER COLUMN adr TYPE FLOAT;

COPY hotel2019 FROM 'C:\Users\dnand\Downloads\hotel_revenue_historical_full-2019.csv' DELIMITER ',' CSV HEADER NULL 'NULL';

SELECT * from hotel2019



--query for meal table

create table mealcost(
	discount_meal float,
	meals varchar(20)
);

COPY mealcost FROM 'C:\Users\dnand\Downloads\hotel_revenue_historical_full-meal.csv' DELIMITER ',' CSV HEADER;

select * from marketseg 



--query for marketseg

create table marketseg(
	discount float,
	markseg varchar(20)
);

COPY marketseg FROM 'C:\Users\dnand\Downloads\hotel_revenue_historical_full-market.csv' DELIMITER ',' CSV HEADER;

select * from marketseg



--query for revenue check

with hotels as (
  select * from hotel2019
  union
  select * from hotel2020
)

SELECT
  arrival_date_year,
  hotel,
  cast(sum((stays_in_weekend_nights + stays_in_week_nights) * adr) AS numeric(10, 2)) AS revenue
FROM
  hotels
GROUP BY
  arrival_date_year,
  hotel;


--final database

with hotels as (
	select * from hotel2019
	union
	select * from hotel2020
)

select * from hotels h

left join marketseg m on h.market_segment = m.markseg
left join mealcost c on h.meal = c.meals
