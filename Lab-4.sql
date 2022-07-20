-------Lab-4-----

--• Stored Procedures

--1. All tables Insert, Update & Delete

	--INSERT
	--1

	ALTER PROCEDURE PR_DEPARTMENT_INSERT
	
	@DEPARTMENTID	INT,
	@DEPARTMENTNAME	VARCHAR(100)
	
	AS
	BEGIN
	
	INSERT INTO DEPARTMENT VALUES
	
	(@DEPARTMENTID,@DEPARTMENTNAME)
	
	END

	EXEC PR_DEPARTMENT_INSERT 1,'ADMIN'
	EXEC PR_DEPARTMENT_INSERT 2,'IT'
	EXEC PR_DEPARTMENT_INSERT 3,'HR'
	EXEC PR_DEPARTMENT_INSERT 4,'ACCOUNT'

	SELECT * FROM DEPARTMENT

	--INSERT
	--2

	CREATE PROCEDURE PR_DESIGNATION_INSERT
	
	@DESIGNATIONTID		INT,
	@DESIGNATIONNAME	VARCHAR(100)
	
	AS
	BEGIN
	
	INSERT INTO DESIGNATION VALUES
	
	(@DESIGNATIONTID,@DESIGNATIONNAME)
	
	END

	EXEC PR_DESIGNATION_INSERT 11,'JOBBER'
	EXEC PR_DESIGNATION_INSERT 12,'WELDER'
	EXEC PR_DESIGNATION_INSERT 13,'CLEARK'
	EXEC PR_DESIGNATION_INSERT 14,'MANAGER'
	EXEC PR_DESIGNATION_INSERT 15,'WORKER'

	SELECT * FROM DESIGNATION

	--INSERT
	--3
	
	CREATE PROCEDURE PR_PERSON_INSERT

	@FIRSTNAME		VARCHAR(100),
	@LASTNAME		VARCHAR(100),
	@SALARY			DECIMAL(8,2),
	@JOINIGDATE		DATETIME,
	@DEPARTMENTID	INT,
	@DESIGNATIONID	INT

	AS 
	BEGIN

	INSERT INTO PERSON VALUES

	(@FIRSTNAME,@LASTNAME,@SALARY,@JOINIGDATE,@DEPARTMENTID,@DESIGNATIONID)

	END

	EXEC PR_PERSON_INSERT 'RAHUL','ANSHU',56000,'01-01-1990',1,12
	EXEC PR_PERSON_INSERT 'HARDIK','HINSU',18000,'1990-09-25',2,11
	EXEC PR_PERSON_INSERT 'BHAVIN','KAMANI',25000,'1991-05-14',NULL,11
	EXEC PR_PERSON_INSERT 'BHOOMI','PATEL',39000,'2014-02-20',1,13
	EXEC PR_PERSON_INSERT 'ROHIT','RAJKOR',17000,'1990-07-23',2,15
	EXEC PR_PERSON_INSERT 'PRIYA','MEHTA',25000,'1990-10-18',2,NULL
	EXEC PR_PERSON_INSERT 'NEHA','TRIVEDI',18000,'2014-02-20',3,15

	SELECT * FROM PERSON


	--UPDATE
	--1

	CREATE PROCEDURE PR_DEPARTMENT_UPDATE

		@DEPARTMENTID	INT,
		@DEPARTMENTNAME	VARCHAR(100)

	AS
	BEGIN

	UPDATE DEPARTMENT
	SET

		DEPARTMENTNAME	=	@DEPARTMENTNAME
		
	WHERE	DEPARTMENTID = @DEPARTMENTID

	END

	EXEC PR_DEPARTMENT_UPDATE 1,ADMIN1
	
	SELECT * FROM DEPARTMENT

	--UPDATE
	--2

	ALTER PROCEDURE PR_DESIGNATION_UPDATE

		@DESIGNATIONTID		INT,
		@DESIGNATIONNAME	VARCHAR(100)

	AS
	BEGIN

	UPDATE DESIGNATION
	SET

		DESIGNATIONNAME =	@DESIGNATIONNAME
		
	WHERE	DESIGNATIONID = @DESIGNATIONTID

	END

	EXEC PR_DESIGNATION_UPDATE 11,JOBBER1
	
	SELECT * FROM DESIGNATION

	--UPDATE
	--3
	
	CREATE PROCEDURE PR_PERSON_UPDATE

		@WORKERID		INT,
		@FIRSTNAME		VARCHAR(100),
		@LASTNAME		VARCHAR(100),
		@SALARY			DECIMAL(8,2),
		@JOINIGDATE		DATETIME,
		@DEPARTMENTID	INT,
		@DESIGNATIONID	INT

	AS 
	BEGIN

	UPDATE PERSON 
	SET

		FIRSTNAME		=	@FIRSTNAME,
		LASTNAME		=	@LASTNAME,
		SALARY			=	@SALARY,
		JOININGDATE		=	@JOINIGDATE,
		DEPARTMENTID	=	@DEPARTMENTID,
		DESIGNATIONID	=	@DESIGNATIONID

	WHERE 	WORKERID		=	@WORKERID

	END

	EXEC  PR_PERSON_UPDATE 103,'RONAK','PATEL',54000,'05-06-2004',2,14
	SELECT * FROM PERSON

	--DELETE
	--1

	CREATE PROCEDURE PR_PERSON_DELETE

		@WORKERID INT

	AS
	BEGIN

		DELETE FROM PERSON
		WHERE WORKERID = @WORKERID

	END

	EXEC PR_PERSON_DELETE 104
	SELECT * FROM PERSON

	--DELETE
	--2

	CREATE PROCEDURE PR_DEPARTMENT_DELETE

		@DEPARTMENTID INT

	AS
	BEGIN

		DELETE FROM DEPARTMENT
		WHERE DEPARTMENTID = @DEPARTMENTID

	END

	EXEC PR_DEPARTMENT_DELETE 4
	SELECT * FROM DEPARTMENT

	--DELETE
	--3

	CREATE PROCEDURE PR_DESIGNATION_DELETE

		@DESIGNATIONID INT

	AS
	BEGIN

		DELETE FROM DESIGNATION
		WHERE DESIGNATIONID = @DESIGNATIONID

	END

	EXEC PR_DESIGNATION_DELETE 14
	SELECT * FROM DESIGNATION

--2. All tables SelectAll (If foreign key is available than do write join and take columns on select list)
--3. All tables SelectPK
--4. Create Procedure that takes Department Name & Designation Name as Input and Returns a table with Worker’s First Name, Salary, Joining Date & Department Name.
--5. Create Procedure that takes FirstName as an input parameter and displays’ all the details of the worker with their department & designation name
--6. Create Procedure which displays department wise maximum, minimum & total salaries.


--• Views

--1. Create a view that display first 100 workers details.
--2. Create a view that displays designation wise maximum, minimum & total salaries.
--3. Create a view that displays Worker’s first name with their salaries & joining date, it also displays duration column which is difference of joining date with respect to current date.
--4. Create a view which shows department & designation wise total number of workers.
--5. Create a view that displays worker names who don’t have either in any department or designation.

--• User Defined Functions
--1. Create a table valued function which accepts DepartmentID as a parameter & returns a worker 
--table based on DepartmentID.
--2. Create a table valued function which returns a table with unique city names from worker table.
--3. Create a scalar valued function which accepts two parameters start date & end date, and 
--returns a date difference in days.
--4. Create a scalar valued function which accepts two parameters year in integer & month in 
--integer and returns total days in passed month & year.
--5. Create a scalar valued function which accepts two parameters year in integer & month in
--integer and returns first date in passed month & year.