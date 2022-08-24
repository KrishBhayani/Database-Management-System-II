--1. Create INSERT, UPDATE & DELETE Stored Procedures for Person table.

	--PR_MST_PERSON_INSERT

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

	--PR_MST_PERSON_UPDATE

	CREATE PROCEDURE PR_MST_PERSON_UPDATE

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


--2. Create a trigger that fires on INSERT, UPDATE and DELETE operation on the Person table. For that, create a new table PersonLog to log (enter) all operations performed on the Employee 
	--table.
--3. Create an INSTEAD OF trigger that fires on INSERT, UPDATE and DELETE operation on the Person table. For that, log all operation performed on the Employee table into PersonLog.
--4. Create DELETE trigger on PersonLog table, when we delete any record of PersonLog table it prints ‘Record deleted successfully from PersonLog’.
--5. Create INSERT trigger on person table, which calculates the age and update that age in Person table.