if not exists (select * from sys.databases where name = 'realtorDatabase')
    create database realtorDatabase
GO

use realtorDatabase
GO

-- DOWN
if exists (select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
    where CONSTRAINT_NAME = 'fk_agents_agent_office_id')
    alter table agents drop constraint fk_agents_agent_office_id

if exists (select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
    where CONSTRAINT_NAME = 'fk_sales_sale_property_id')
    alter table sales drop constraint fk_sales_sale_property_id

if exists (select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
    where CONSTRAINT_NAME = 'fk_sales_sale_agent_id')
    alter table sales drop constraint fk_sales_sale_agent_id

if exists (select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
    where CONSTRAINT_NAME = 'fk_sales_sale_client_id')
    alter table sales drop constraint fk_sales_sale_client_id

if exists (select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
    where CONSTRAINT_NAME = 'fk_appointments_appointment_property_id')
    alter table appointments drop constraint fk_appointments_appointment_property_id

if exists (select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
    where CONSTRAINT_NAME = 'fk_appointments_appointment_client_id')
    alter table appointments drop constraint fk_appointments_appointment_client_id

if exists (select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
    where CONSTRAINT_NAME = 'fk_appointments_appointment_agent_id')
    alter table appointments drop constraint fk_appointments_appointment_agent_id

drop table if exists clients

drop table if exists properties

drop table if exists offices

drop table if exists agents

drop table if exists sales

drop table if exists appointments

GO

-- UP Metadata
create table clients (
    client_id int identity not null,
    client_email varchar(50) not null,
    client_phone_number varchar(20) not null,
    client_firstname varchar(50) not null,
    client_lastname varchar(50) not null,
    constraint pk_clients_client_id primary key (client_id),
    constraint u_clients_client_email unique (client_email),
    constraint u_clients_client_phone_number unique (client_phone_number),
)

create table offices (
    office_id int identity not null,
    office_street varchar(50) not null,
    office_city varchar(50) not null,
    office_state varchar(50) not null,
    office_zipcode varchar(20) not null,
    constraint pk_offices_office_id primary key (office_id),
    constraint u_offices_office_street unique (office_street),
)

create table properties (
    property_id int identity not null,
    property_street varchar(50) not null,
    property_city varchar(50) not null,
    property_state varchar(50) not null,
    property_zipcode varchar(20) not null,
    property_price money null,
    property_type varchar(50) null,
    property_square_footage numeric not null,
    property_beds numeric null,
    property_baths numeric null,
    property_list_date date not null,
    property_status varchar(50) not null,
    constraint pk_properties_property_id primary key (property_id),
    constraint u_properties_property_street unique (property_street),
)


create table agents (
    agent_id int identity not null,
    agent_email varchar(50) not null,
    agent_phone_number varchar(20) not null,
    agent_firstname varchar(50) not null,
    agent_lastname varchar(50) not null,
    agent_certification varchar(50) null,
    agent_office_id int not null,
    constraint pk_agents_agent_id primary key (agent_id),
    constraint u_agents_agent_email unique (agent_email),
    constraint u_agents_agent_phone_number unique (agent_phone_number),
)
alter table agents
    add constraint fk_agents_agent_office_id foreign key (agent_office_id)
    references offices(office_id)

create table sales (
    sale_id int identity not null,
    sale_price money not null,
    sale_date date not null,
    sale_notes varchar(200) null,
    sale_property_id int not null,
    sale_agent_id int not null,
    sale_client_id int not null,
    constraint pk_sales_sale_id primary key (sale_id),
)
alter table sales
    add constraint fk_sales_sale_property_id foreign key (sale_property_id)
    references properties (property_id)

alter table sales
    add constraint fk_sales_sale_agent_id foreign key (sale_agent_id)
    references agents (agent_id)

alter table sales
    add constraint fk_sales_sale_client_id foreign key (sale_client_id)
    references clients (client_id)

create table appointments (
    appointment_id int identity not null,
    appointment_time time null,
    appointment_date date null,
    appointment_notes varchar(200) null,
    appointment_property_id int not null,
    appointment_client_id int not null,
    appointment_agent_id int not null,
    constraint pk_appointments_appointment_id primary key (appointment_id),
)
alter table appointments
    add constraint fk_appointments_appointment_property_id foreign key (appointment_property_id)
    references properties (property_id)

alter table appointments
    add constraint fk_appointments_appointment_client_id foreign key (appointment_client_id)
    references clients (client_id)

alter table appointments
    add constraint fk_appointments_appointment_agent_id foreign key (appointment_agent_id)
    references agents (agent_id)


-- UP Data

-- Verify
select * from clients

select * from agents

select * from offices

select * from properties

select * from appointments

select * from sales
