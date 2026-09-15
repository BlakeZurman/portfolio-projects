use realtorDatabase
go


-- Adding Clients

-- Add first client
EXEC sp_AddClient
    @client_email = 'alice.smith@example.com',
    @client_phone_number = '555-1111',
    @client_firstname = 'Alice',
    @client_lastname = 'Smith';

-- Add second client
EXEC sp_AddClient
    @client_email = 'bob.jones@example.com',
    @client_phone_number = '555-2222',
    @client_firstname = 'Bob',
    @client_lastname = 'Jones';

-- Add third client
EXEC sp_AddClient
    @client_email = 'charlie.brown@example.com',
    @client_phone_number = '555-3333',
    @client_firstname = 'Charlie',
    @client_lastname = 'Brown';

-- Adding Offices

-- Add first office
EXEC sp_AddOffice
    @office_street = '123 Orange St',
    @office_city = 'Syracuse',
    @office_state = 'NY',
    @office_zipcode = '12345';

-- Add second office
EXEC sp_AddOffice
    @office_street = '456 Beach St',
    @office_city = 'Miami',
    @office_state = 'FL',
    @office_zipcode = '54321';

-- Adding Agents

-- Add first agent
EXEC sp_AddAgent
    @agent_email = 'BlakeZurman@example.com',
    @agent_phone_number = '555-9876',
    @agent_firstname = 'Blake',
    @agent_lastname = 'Zurman',
    @agent_certification = 'Fake Certified Realtor',
    @agent_office_id = 1;

-- Add second agent
EXEC sp_AddAgent
    @agent_email = 'JerrySpina@example.com',
    @agent_phone_number = '555-6543',
    @agent_firstname = 'John',
    @agent_lastname = 'Smith',
    @agent_certification = 'Totally real Senior Realtor',
    @agent_office_id = 2;

-- Add third agent
EXEC sp_AddAgent
    @agent_email = 'MadeUpGuy@example.com',
    @agent_phone_number = '555-4321',
    @agent_firstname = 'Fake',
    @agent_lastname = 'Guy',
    @agent_certification = 'Realtor Associate',
    @agent_office_id = 1;
-- Add Properties

-- Add first property
EXEC sp_AddProperty
    @property_street = '789 Maple St',
    @property_city = 'Amherst',
    @property_state = 'MA',
    @property_zipcode = '01002',
    @property_price = 350000,
    @property_type = 'Single Family',
    @property_square_footage = 1500,
    @property_beds = 3,
    @property_baths = 2,
    @property_list_date = '2024-09-04',
    @property_status = 'Available';

-- Add second property
EXEC sp_AddProperty
    @property_street = '101 Cedar St',
    @property_city = 'Amherst',
    @property_state = 'MA',
    @property_zipcode = '01002',
    @property_price = 450000,
    @property_type = 'Condo',
    @property_square_footage = 2000,
    @property_beds = 4,
    @property_baths = 3,
    @property_list_date = '2024-09-04',
    @property_status = 'Available';


select * from agents 
select * from clients
select * from properties
select * from Offices


