drop database if exists property_managemant_project;

create database property_managemant_project;
use property_managemant_project;


create table property
(property_id varchar(50) primary key,
street varchar(50),
city varchar(50),
state varchar(50),
zip varchar(50),
bathroom int(2),
bedroom int(2),
square_footage int(10),
property_states enum("occupied","vacant","under_maintenance"),
type_name enum("apartment","condo","single_family")
);
insert into property
(property_id,street,city,state,zip,bathroom,bedroom,square_footage,property_states,type_name)values
("P001","12 George St","Sydney","NSW","2000",2,3,1200,"vacant","apartment"),
("P002","45 King St","Sydney","NSW","2000",1,2,900,"vacant","condo"),
("P003","78 Queen St","Parramatta","NSW","2150",2,4,1500,"occupied","single_family"),
("P004","22 Pitt St","Sydney","NSW","2000",1,1,700,"under_maintenance","apartment"),
("P005","10 Church St","Liverpool","NSW","2170",2,3,1100,"occupied","condo");

create table tenant
(tenant_id varchar(50) primary key,
first_name varchar(50),
last_name varchar(20),
email varchar(30),
date_of_birth date,
phone_number varchar(50),
emergency_name varchar(50),
emergency_number varchar(50) not null,
relationship varchar(50)
);
alter table tenant
add constraint check_phone_numeric
check (phone_number regexp "^[0-9]+$");

insert into tenant
(tenant_id,first_name,last_name,email,date_of_birth,phone_number,emergency_name,emergency_number,relationship)values
("T001","John","Smith","john.smith@email.com","1995-06-15","0412345678","Mary Smith","0498765432","Mother"),
("T002","Sarah","Lee","sarah.lee@email.com","1998-03-20","0423456789","David Lee","0487654321","Father"),
("T003","Michael","Brown","michael.b@email.com","1992-11-10","0434567890","Anna Brown","0476543210","Sister"),
("T004","Emily","Davis","emily.d@email.com","1997-08-05","0445678901","James Davis","0465432109","Brother"),
("T005","Chris","Wilson","chris.w@email.com","1990-01-25","0456789012","Laura Wilson","0454321098","Spouse");


create table lease
(lease_id varchar(50) primary key,
lease_states enum("active","expired","terminated"),
tenant_id varchar(50),
property_id varchar(50),
monthly_rental_amount int(10),
security_deposit_amount int(10),
start_date date,
end_date date,
foreign key(tenant_id) references tenant(tenant_id),
foreign key(property_id) references property(property_id)
);
insert into lease
(lease_id,lease_states,tenant_id,property_id,monthly_rental_amount,security_deposit_amount,start_date,end_date)values
("L001","active","T001","P001",2000,2000,"2024-01-01","2025-01-01"),
("L002","expired","T002","P003",2500,2500,"2024-02-01","2025-02-01"),
("L003","terminated","T003","P005",1800,1800,"2023-01-01","2024-01-01"),
("L004","active","T004","P001",2100,2000,"2024-03-01","2025-03-01");

create table maintenance_requests
(request_id varchar(50) primary key,
property_id varchar(50),
tenant_id varchar(50),
resolution_states enum("open","in_progress","closed"),
priority_level enum("urgent","medium","low"),
request_date date,
description_of_issue varchar(500),
foreign key(property_id) references property(property_id),
foreign key(tenant_id) references tenant(tenant_id)
);
insert into maintenance_requests
(request_id,property_id,tenant_id,resolution_states,priority_level,request_date,description_of_issue)values
("M001", "P001", "T001", "open", "urgent", "2025-01-10", "Air conditioner not working"),
("M002", "P003", "T002", "in_progress", "medium", "2025-01-12", "Leaking sink in kitchen"),
("M003", "P004", "T004", "open", "urgent", "2025-01-15", "Electrical issue in living room"),
("M004", "P005", "T003", "closed", "low", "2025-01-18", "Broken window repair"),
("M005", "P001", "T001", "in_progress", "medium", "2025-01-20", "Water heater issue");

create table payment
(payment_id int(10) primary key,
lease_id varchar(10),
payment_states enum("completed","pending","failed"),
payment_method enum("credit_card","cash","bank_transfer"),
amount_paid int(10),
payment_date date,
foreign key(lease_id) references lease(lease_id)
);
insert into payment
(payment_id, lease_id, payment_states, payment_method, amount_paid, payment_date)values
(1, "L001", "completed", "credit_card", 2000, "2025-01-05"),
(2, "L001", "completed", "cash", 2000, "2025-02-05"),
(3, "L002", "pending", "bank_transfer", 2500, "2025-01-06"),
(4, "L003", "completed", "credit_card", 1800, "2024-12-01"),
(5, "L004", "failed", "cash", 2100, "2025-01-07");


select *
from property;

select *
from tenant;

select *
from lease;

select *
from maintenance_requests;

select *
from payment;

-- Retrieve the full name of each tenant and the address of the property they are renting
select t.first_name, t.last_name, p.street, p.city
from tenant t
join lease l on t.tenant_id = l.tenant_id
join property p on l.property_id = p.property_id;

-- Calculate the total amount of rent paid by each tenant (Grouped by name)
select t.first_name, sum(p.amount_paid) as total_paid
from tenant t
join lease l on t.tenant_id = l.tenant_id 
join payment p on  l.lease_id = p.lease_id
group by t.first_name;

-- Show all payment records that are currently in 'pending' status
select *
from payment
where payment_states = "pending";

-- List all maintenance requests that are marked with an 'urgent' priority level
select *
from maintenance_requests
where priority_level = "urgent";

-- Find all properties that are currently being repaired or under maintenance
select *
from property
where property_states = "under_maintenance";

-- find all properties that are not occupied
select *
from property
where property_states != "occupied";

-- find how many properties are of each type
select type_name, count(*)
from property
group by type_name;

-- combined properties
select street,city
from property
where property_states = "vacant"
and type_name = "apartment";


