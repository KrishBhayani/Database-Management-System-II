--1. Create INSERT, UPDATE & DELETE Stored Procedures for Person table.

	--PR_PERSON_INSERT

	CREATE PROCEDURE PR_PERSON_INSERT

	@PERSONID			INT,
	@PERSONAME			VARCHAR(50),
	@SALARY				DECIMAL(8,2),
	@JOININGDATE		DATETIME,
	@CITY				VARCHAR(100),
	@AGE				INT,
	@BIRTHDATE			DATETIME

	AS
	BEGIN

	INSERT INTO PERSON VALUES

	(@PERSONID,@PERSONAME,@SALARY,@JOININGDATE,@CITY,@AGE,@BIRTHDATE)

	END

	EXEC PR_PERSON_INSERT 1,KRISH,36000,'2020-01-01',RAJKOT,25,'1997-01-01'
	EXEC PR_PERSON_INSERT 2,DEEP,30000,'2021-01-01',AHEMADABAD,27,'1995-01-01'
	EXEC PR_PERSON_INSERT 3,AKSHAY,35000,'2022-01-01',BARODA,23,'1999-01-01'

	SELECT * FROM Person;

	--PR_PERSON_UPDATE

	CREATE PROCEDURE PR_PERSON_UPDATE

	@PERSONID			INT,
	@PERSONNAME			VARCHAR(50),
	@SALARY				DECIMAL(8,2),
	@JOININGDATE		DATETIME,
	@CITY				VARCHAR(100),
	@AGE				INT,
	@BIRTHDATE			DATETIME

	AS
	BEGIN

	UPDATE PERSON

	SET		PERSONNAME	=	@PERSONNAME,
			SALARY		=	@SALARY,
			JOININGDATE	=	@JOININGDATE,
			CITY	=	@CITY,
			AGE			=	@AGE,
			BIRTHDATE	=	@BIRTHDATE

	WHERE	PERSONID	=	@PERSONID

	END

	EXEC	PR_PERSON_UPDATE 2,DEEP,40000,'2021-01-01',AHEMADABAD,27,'1995-01-01'

	SELECT * FROM Person;

	--PR_MST_PERSON_DELETE

	CREATE PROCEDURE PR_PERSON_DELETE

	@PERSONID	INT

	AS
	BEGIN

	DELETE FROM PERSON WHERE
		
		PERSONID = @PERSONID

	END

	EXEC PR_PERSON_DELETE 3

	SELECT * FROM Person;

--2. Create a trigger that fires on INSERT, UPDATE and DELETE operation on the Person table. For that, create a new table PersonLog to log (enter) all operations performed on the Employee 
	--table.

	--INSERT

	CREATE TRIGGER INSERT_PERSON_FOR
	ON PERSON
	FOR INSERT
	AS
	BEGIN
		DECLARE @PERSONID INT
		DECLARE @PERSONNAME VARCHAR(50)
		SELECT @PERSONID = PERSONID FROM inserted
		SELECT @PERSONNAME = PERSONNAME FROM inserted

		INSERT INTO PersonLog 
		VALUES (@PERSONID,@PERSONNAME,'INSERT',GETDATE());
	END

	INSERT INTO Person VALUES (3,'AKSHAY',35000,'2022-01-01','BARODA',23,'1999-01-01')
	INSERT INTO Person VALUES (4,'YASH',45000,'2017-01-01','RAJKOT',29,'1993-01-01')

	SELECT * FROM Person
	SELECT * FROM PersonLog

	--UPDATE

	CREATE TRIGGER UPDATE_PERSON_FOR
	ON PERSON
	FOR UPDATE
	AS
	BEGIN
		DECLARE @PERSONID INT
		DECLARE @PERSONNAME VARCHAR(50)
		SELECT @PERSONID = PERSONID FROM inserted
		SELECT @PERSONNAME = PERSONNAME FROM inserted

		INSERT INTO PersonLog 
		VALUES (@PERSONID,@PERSONNAME,'UPDATE',GETDATE());
	END

	UPDATE PERSON SET SALARY = 50000 WHERE PERSONID = 1
	UPDATE PERSON SET SALARY = 42000 WHERE PERSONID = 3

	SELECT * FROM Person
	SELECT * FROM PersonLog

	--DELETE

	CREATE TRIGGER DELETE_PERSON_FOR
	ON PERSON
	FOR DELETE
	AS
	BEGIN
		DECLARE @PERSONID INT
		DECLARE @PERSONNAME VARCHAR(50)
		SELECT @PERSONID = PERSONID FROM deleted
		SELECT @PERSONNAME = PERSONNAME FROM deleted

		INSERT INTO PersonLog 
		VALUES (@PERSONID,@PERSONNAME,'DELETE',GETDATE());
	END

	DELETE FROM Person WHERE PersonID = 3;

	SELECT * FROM Person
	SELECT * FROM PersonLog

--3. Create an INSTEAD OF trigger that fires on INSERT, UPDATE and DELETE operation on the Person table. For that, log all operation performed on the Employee table into PersonLog.

	--INSERT

	CREATE TRIGGER INSERT_PERSON_INSTEAD
	ON PERSON
	INSTEAD OF INSERT

	AS
	BEGIN
		DECLARE @PERSONID INT
		DECLARE @PERSONNAME VARCHAR(50)
		SELECT @PERSONID = PERSONID FROM inserted
		SELECT @PERSONNAME = PERSONNAME FROM inserted

		INSERT INTO PersonLog 
		VALUES (@PERSONID,@PERSONNAME,'INSERT',CAST(GETDATE()AS varchar(50)))
	END

	INSERT INTO Person VALUES (5,'AKSHAY',35000,'2022-01-01','BARODA',23,'1999-01-01')
	INSERT INTO Person VALUES (4,'YASH',45000,'2017-01-01','RAJKOT',29,'1993-01-01')

	SELECT * FROM PersonLog

	--UPDATE

	CREATE TRIGGER UPDATE_PERSON_INSTEAD
	ON PERSON
	INSTEAD OF UPDATE

	AS
	BEGIN
		DECLARE @PERSONID INT
		DECLARE @PERSONNAME VARCHAR(50)
		SELECT @PERSONID = PERSONID FROM inserted
		SELECT @PERSONNAME = PERSONNAME FROM inserted

		INSERT INTO PersonLog 
		VALUES (@PERSONID,@PERSONNAME,'UPDATE',CAST(GETDATE()AS varchar(50)))
	END

	UPDATE PERSON SET SALARY = 44000 WHERE PERSONID = 1
	UPDATE PERSON SET SALARY = 52000 WHERE PERSONID = 2

	SELECT * FROM PersonLog

	--DELETE

	ALTER TRIGGER DELETE_PERSON_INSTEAD
	ON PERSON
	INSTEAD OF DELETE

	AS
	BEGIN
		DECLARE @PERSONID INT
		DECLARE @PERSONNAME VARCHAR(50)
		SELECT @PERSONID = PERSONID FROM deleted
		SELECT @PERSONNAME = PERSONNAME FROM deleted

		INSERT INTO PersonLog 
		VALUES (@PERSONID,@PERSONNAME,'DELETE',CAST(GETDATE()AS varchar(50)))
	END

	DELETE FROM PERSON WHERE PERSONID = 4
	
	SELECT * FROM PersonLog

--4. Create DELETE trigger on PersonLog table, when we delete any record of PersonLog table it prints �Record deleted successfully from PersonLog�.

	CREATE TRIGGER DELETE_PERSON
	ON PERSONLOG
	FOR DELETE

	AS 
	BEGIN
		PRINT('RECORD DELETED SUCCESSFUULY FROM PERSONLOG')
	END

	DELETE FROM PersonLog WHERE PLogID=8

--5. Create INSERT trigger on person table, which calculates the age and update that age in Person table.

	CREATE TRIGGER UPDATE_AGE_FOR
	ON PERSON
	FOR INSERT
	AS 
	BEGIN
		DECLARE @PERSONID INT
		DECLARE @BIRTHDATE DATETIME

		SELECT @PERSONID = PERSONID FROM inserted 
		SELECT @BIRTHDATE = BirthDate FROM inserted 

		UPDATE Person
		SET Age = CONVERT(int,DATEDIFF(YEAR,@BIRTHDATE,GETDATE()))
		WHERE @PERSONID = PERSONID
	END

	INSERT INTO PERSON VALUES(5,'NEVIL',15000,'2021-01-01','SURAT',40,'2001-01-01')

	SELECT * FROM Person
	SELECT * FROM PersonLog