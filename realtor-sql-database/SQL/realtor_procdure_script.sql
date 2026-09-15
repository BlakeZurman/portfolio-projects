USE realtorDatabase;
GO

-- Add office
drop procedure if exists sp_AddOffice
go
CREATE PROCEDURE sp_AddOffice
    @office_street VARCHAR(50),
    @office_city VARCHAR(50),
    @office_state VARCHAR(50),
    @office_zipcode VARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        INSERT INTO offices (
            office_street,
            office_city,
            office_state,
            office_zipcode
        )
        VALUES (
            @office_street,
            @office_city,
            @office_state,
            @office_zipcode
        );

        SELECT SCOPE_IDENTITY() AS NewOfficeID;
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        ROLLBACK TRANSACTION;

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;
GO

-- Add agent
drop PROCEDURE if exists sp_AddAgent
go
CREATE PROCEDURE sp_AddAgent
    @agent_email VARCHAR(50),
    @agent_phone_number VARCHAR(20),
    @agent_firstname VARCHAR(50),
    @agent_lastname VARCHAR(50),
    @agent_certification VARCHAR(50) = NULL,
    @agent_office_id INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        INSERT INTO agents (
            agent_email,
            agent_phone_number,
            agent_firstname,
            agent_lastname,
            agent_certification,
            agent_office_id
        )
        VALUES (
            @agent_email,
            @agent_phone_number,
            @agent_firstname,
            @agent_lastname,
            @agent_certification,
            @agent_office_id
        );

        SELECT SCOPE_IDENTITY() AS NewAgentID;
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        ROLLBACK TRANSACTION;

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;
GO

-- Add property
drop procedure if exists sp_AddProperty
go
CREATE PROCEDURE sp_AddProperty
    @property_street VARCHAR(50),
    @property_city VARCHAR(50),
    @property_state VARCHAR(50),
    @property_zipcode VARCHAR(20),
    @property_price MONEY = NULL,
    @property_type VARCHAR(50) = NULL,
    @property_square_footage NUMERIC,
    @property_beds NUMERIC = NULL,
    @property_baths NUMERIC = NULL,
    @property_list_date DATE,
    @property_status VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        INSERT INTO properties (
            property_street,
            property_city,
            property_state,
            property_zipcode,
            property_price,
            property_type,
            property_square_footage,
            property_beds,
            property_baths,
            property_list_date,
            property_status
        )
        VALUES (
            @property_street,
            @property_city,
            @property_state,
            @property_zipcode,
            @property_price,
            @property_type,
            @property_square_footage,
            @property_beds,
            @property_baths,
            @property_list_date,
            @property_status
        );

        -- Return the ID of the newly inserted property
        SELECT SCOPE_IDENTITY() AS NewPropertyID;
    END TRY
    BEGIN CATCH
        -- Handle errors
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        -- Rollback in case of error
        ROLLBACK TRANSACTION;

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;
GO

-- Add client
DROP PROCEDURE IF EXISTS sp_AddClient;
GO
CREATE PROCEDURE sp_AddClient
  @client_email VARCHAR(50),
  @client_phone_number VARCHAR(20),
  @client_firstname VARCHAR(50),
  @client_lastname VARCHAR(50)
AS
BEGIN
  BEGIN TRANSACTION;
  BEGIN TRY
    IF NOT EXISTS (SELECT 1 FROM clients WHERE client_email = @client_email OR client_phone_number = @client_phone_number)
    BEGIN
      INSERT INTO clients (client_email, client_phone_number, client_firstname, client_lastname)
      VALUES (@client_email, @client_phone_number, @client_firstname, @client_lastname);
    END
    ELSE
    BEGIN
      RAISERROR('A client with this email or phone number already exists.', 16, 1);
      ROLLBACK TRANSACTION;
      RETURN;
    END
    COMMIT TRANSACTION;
  END TRY
  BEGIN CATCH
    ROLLBACK TRANSACTION;
    THROW;
  END CATCH
END;
GO

-- Add Sale
DROP PROCEDURE IF EXISTS sp_AddSale;
GO
CREATE PROCEDURE sp_AddSale
    @sale_price MONEY,
    @sale_date DATE,
    @sale_notes VARCHAR(200) = NULL,
    @sale_property_id INT,
    @sale_agent_id INT,
    @sale_client_id INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRANSACTION;
    BEGIN TRY
        -- Insert the sale
        INSERT INTO sales (
            sale_price,
            sale_date,
            sale_notes,
            sale_property_id,
            sale_agent_id,
            sale_client_id
        )
        VALUES (
            @sale_price,
            @sale_date,
            @sale_notes,
            @sale_property_id,
            @sale_agent_id,
            @sale_client_id
        );

        -- Commit transaction on success
        COMMIT TRANSACTION;

        -- Return the new sale ID
        SELECT SCOPE_IDENTITY() AS NewSaleID;
    END TRY
    BEGIN CATCH
        -- Rollback transaction on error
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        -- Raise error
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;
GO


-- List available properties
DROP PROCEDURE IF EXISTS ListAvailableProperties;
GO
CREATE PROCEDURE ListAvailableProperties
  @city VARCHAR(50) = NULL,
  @min_price MONEY = NULL,
  @max_price MONEY = NULL
AS
BEGIN
  SELECT *
  FROM properties
  WHERE property_status = 'available'
    AND (@city IS NULL OR property_city = @city)
    AND (@min_price IS NULL OR property_price >= @min_price)
    AND (@max_price IS NULL OR property_price <= @max_price);
END;
GO

-- Record a property sale
DROP PROCEDURE IF EXISTS RecordPropertySale;
GO
CREATE PROCEDURE RecordPropertySale
  @sale_price MONEY,
  @sale_date DATE,
  @sale_property_id INT,
  @sale_agent_id INT,
  @sale_client_id INT
AS
BEGIN
  BEGIN TRANSACTION;
  BEGIN TRY
    INSERT INTO sales (sale_price, sale_date, sale_property_id, sale_agent_id, sale_client_id)
    VALUES (@sale_price, @sale_date, @sale_property_id, @sale_agent_id, @sale_client_id);
    
    UPDATE properties
    SET property_status = 'sold'
    WHERE property_id = @sale_property_id;

    COMMIT TRANSACTION;
  END TRY
  BEGIN CATCH
    ROLLBACK TRANSACTION;
    THROW;
  END CATCH
END;
GO

-- Schedule appointment
DROP PROCEDURE IF EXISTS ScheduleAppointment;
GO
CREATE PROCEDURE ScheduleAppointment
  @appointment_date DATE,
  @appointment_time TIME,
  @appointment_property_id INT,
  @appointment_client_id INT,
  @appointment_agent_id INT,
  @appointment_notes VARCHAR(200) = NULL
AS
BEGIN
  BEGIN TRANSACTION;
  BEGIN TRY
    INSERT INTO appointments (appointment_date, appointment_time, appointment_property_id, appointment_client_id, appointment_agent_id, appointment_notes)
    VALUES (@appointment_date, @appointment_time, @appointment_property_id, @appointment_client_id, @appointment_agent_id, @appointment_notes);

    COMMIT TRANSACTION;
  END TRY
  BEGIN CATCH
    ROLLBACK TRANSACTION;
    THROW;
  END CATCH
END;
GO

