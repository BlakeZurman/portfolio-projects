use realtorDatabase
go

-- if you want to filter sales by agent id and then sort it by date
IF EXISTS (SELECT name FROM sys.indexes WHERE name = 'idx_sales_agent_date')
    DROP INDEX idx_sales_agent_date ON sales;
CREATE INDEX idx_sales_agent_date ON sales(sale_agent_id, sale_date);

-- if you want to see the appoinments clients have filtered by client id and sorted by date
IF EXISTS (SELECT name FROM sys.indexes WHERE name = 'idx_appointments_client_date_time')
    DROP INDEX idx_appointments_client_date_time ON appointments;
CREATE INDEX idx_appointments_client_date_time ON appointments(appointment_client_id, appointment_date, appointment_time);

-- this helps when looking at property sales dates
IF EXISTS (SELECT name FROM sys.indexes WHERE name = 'idx_sales_property_date')
    DROP INDEX idx_sales_property_date ON sales;
CREATE INDEX idx_sales_property_date ON sales(sale_property_id, sale_date);

-- although our data base doesn't currently support clients making multiple purchases of homes, this index helps see client purchase history
IF EXISTS (SELECT name FROM sys.indexes WHERE name = 'idx_sales_client_date')
    DROP INDEX idx_sales_client_date ON sales;
CREATE INDEX idx_sales_client_date ON sales(sale_client_id, sale_date);

-- helps when looking at property status
IF EXISTS (SELECT name FROM sys.indexes WHERE name = 'idx_properties_status')
    DROP INDEX idx_properties_status ON properties;
CREATE INDEX idx_properties_status ON properties(property_status);

-- this is if you wanted to see sales in a certain period of time
IF EXISTS (SELECT name FROM sys.indexes WHERE name = 'idx_sales_date_range')
    DROP INDEX idx_sales_date_range ON sales;
CREATE INDEX idx_sales_date_range ON sales(sale_date);

