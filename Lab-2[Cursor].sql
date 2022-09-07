--1. Print message like - Error Occur that is: Divide by zero error encountered.
	BEGIN TRY
		SELECT 1/0;
	END TRY

	BEGIN CATCH
		SELECT 'ERROR OCCUR THAT IS : '+ERROR_MESSAGE() AS ERROR_MSG;
	END CATCH
--2. Print error message in insert statement using Error_Message () function: Conversion failed when converting datetime from character string.
	
	BEGIN TRY
		DECLARE @DATE_TIME_VALUE VARCHAR(100) = '10/16/2015 21:02:04'
		SELECT CONVERT(datetime,@DATE_TIME_VALUE,5) AS CONVERSION
	END TRY

	BEGIN CATCH
		SELECT ERROR_MESSAGE() AS ERROR_MSG;
	END CATCH

--3. Create procedure which prints the error message that “The PLogID is already taken. Try another one”.
	
	CREATE PROCEDURE PLOG_TAKEN
		@PLOG INT,
		@PNAME VARCHAR(50)
	AS
	BEGIN
		BEGIN TRY
			INSERT INTO PERSONLOG VALUES(@PLOG,@PNAME,'INSERT',GETDATE())
		END TRY

		BEGIN CATCH 
			PRINT 'THE PLOGID IS ALREADY TAKEN. TRY ANOTHER ONE'
		END CATCH
	END

	EXEC PLOG_TAKEN 1,ABC
	EXEC PLOG_TAKEN 1,XYZ

	SELECT * FROM PERSONLOG

--4. Create procedure that print the sum of two numbers: take both number as integer & handle exception with all error functions 
	--if any one enters string value in numbers otherwise print result.

	CREATE PROCEDURE ADDITION_TWO_NO
		@NUMBER1 VARCHAR(5),
		@NUMBER2 INT,
		@RESULT INT OUTPUT

		AS
		BEGIN
			
			BEGIN TRY
				SET @RESULT = @NUMBER1 + @NUMBER2;
			END TRY

			BEGIN CATCH
				SELECT 
					ERROR_MESSAGE() AS [ERROR MESSAGE],
					ERROR_SEVERITY() AS [ERROR SEVERITY],
					ERROR_STATE() AS [ERROR STATE],
					ERROR_PROCEDURE() AS [ERROR PROCEDURE],
					ERROR_MESSAGE() AS [ERROR MESSAGE],
					ERROR_LINE() AS [ERROR LINE]
			END CATCH
		END

		DECLARE @R INT;
		EXEC ADDITION_TWO_NO 'A',2,@R OUTPUT;
		PRINT R;

--5. Throw custom exception using stored procedure which accepts PLogID as input & that throws Error like no plogid is available in database.

	ALTER PROCEDURE FINDPLOG
		@PLOGID INT
	AS
	BEGIN
		IF EXISTS(SELECT * FROM PERSONLOG WHERE PLOGID=@PLOGID)
			PRINT('PLOGID IS AVAILABLE IN THE DATABASE')
		ELSE 
			THROW 50005,'ERROR! NO PLOGDID WITH THIS ID',1
	END

	EXEC FINDPLOG 20;

--6. Create cursor with name per_cursor which takes PLogID & PersonName as variable and produce combine output with PLogID & Person Name.

	DECLARE
		@PLOGID INT,
		@PERSINNAME VARCHAR(250)
	DECLARE PER_CURSOR CURSOR
	FOR SELECT
			PLOGID,
			PERSINNAME
		FROM
			PERSONLOG;
	OPEN PER_CURSOR
	FETCH NEXT FROM PER_CURSOR INTO
		@PLOGID,
		@PERSINNAME;
	WHILE @@FETCH_STATUS=0
		BEGIN
			PRINT CAST(@PLOGID AS VARCHAR) + '-' + @PERSINNAME;
			FETCH NEXT FROM PER_CURSOR INTO
				@PLOGID,
				@PERSINNAME;
		END;
	CLOSE PER_CURSOR;
	DEALLOCATE PER_CURSOR;

	SELECT * FROM PERSONLOG


--7. Use Table Student (Id, Rno, EnrollmentNo, Name, Branch, University) - Create cursor that updates enrollment column as combination of branch & 
	--Roll No. like SOE22CE0001 and so on. (22 is admission year)	DECLARE 		@RNO INT,		@BRANCH VARCHAR(50);	DECLARE ENROLLMENT_CURSOR CURSOR	FOR SELECT			RNO,			BRANCH		FROM STUDENT;	OPEN ENROLLMENT_CURSOR;	FETCH NEXT FROM ENROLLMENT_CURSOR INTO		@RNO,		@BRANCH;	WHILE @@FETCH_STATUS=0	BEGIN		UPDATE STUDENT SET ENROLLMENTNO = 'SOE22' + @BRANCH + CAST(@RNO AS VARCHAR)			WHERE RNO=@RNO;		FETCH NEXT FROM ENROLLMENT_CURSOR INTO			@RNO,			@BRANCH;	END;	CLOSE ENROLLMENT_CURSOR;
	DEALLOCATE ENROLLMENT_CURSOR;

	SELECT * FROM STUDENT;