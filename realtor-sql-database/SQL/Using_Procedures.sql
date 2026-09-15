-- Add a sale
EXEC sp_AddSale
    @sale_price = 300000,
    @sale_date = '2024-09-04',
    @sale_notes = 'Cash buyer, quick closing',
    @sale_property_id = 1,  
    @sale_agent_id = 4,     
    @sale_client_id = 1;    

-- List available properties in Greenfield with a price range
EXEC ListAvailableProperties
    @city = 'Amherst',
    @min_price = 200000,
    @max_price = 400000;

-- List all available properties
EXEC ListAvailableProperties;

-- Record a property sale
EXEC RecordPropertySale
    @sale_price = 450000,
    @sale_date = '2024-09-04',
    @sale_property_id = 2,   
    @sale_agent_id = 5,    
    @sale_client_id = 2;     

-- Schedule an appointment
EXEC ScheduleAppointment
    @appointment_date = '2024-09-07',
    @appointment_time = '10:00:00',
    @appointment_property_id = 2,   
    @appointment_client_id = 2,    
    @appointment_agent_id = 5,      
    @appointment_notes = 'Client seems sketchy';

select * from agents 
select * from clients
select * from properties
select * from Offices
select * from sales 
select * from appointments

