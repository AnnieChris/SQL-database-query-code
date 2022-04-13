use mars_new;
select * from product;

/*create procedure expensiveProductList
as
BEGIN
	SELECT
		prod_name, prod_desc, price
	from product
	where price > 400
END

execute expensiveProductList 
exec expensiveProductList	-- use anyone its a short form which also works the same */

--Procedure with parameter
/* create procedure priceLessThan(@price as decimal)
as
BEGIN
	SELECT
		prod_name, prod_desc, price
	from product
	where price < @price
END

execute priceLessThan 300	*/

/* CREATE PROCEDURE DELLPRODUCTS AS
BEGIN 
DECLARE @PROD_DESC VARCHAR(10)

SET @PROD_DESC = 'DELL'

SELECT PROD_NAME, PROD_DESC, PRICE

FROM PRODUCT
WHERE PROD_DESC = @PROD_DESC
END

EXEC DELLPRODUCTS */

--output parameter
/* CREATE PROCEDURE uspFindProductByDesc(@prod_des varchar(20), @prod_count int output)
as
begin
	select
		prod_name, price
	from
		product
	where
		prod_desc = @prod_des;
	select @prod_count = @@ROWCOUNT;
END;

declare @count int
exec uspFindProductByDesc 'DELL', @count output;

select @count as 'Number of product found'; */



/*BEGIN
	select
		prod_name, price
	from
		product
	where
		PRICE > 300

	if @@ROWCOUNT = 0
		print 'No product found !!'
	else
		print 'Found product'
END;*/


/*BEGIN
	select
		prod_name, price
	from
		product
	where
		PRICE > 300
		print 'found' + cast(@@ROWCOUNT as varchar) +' product';

END;*/

/*
--cursor declaration
	DECLARE
		@PRODUCT_NAME VARCHAR(10),
		@PRODUCT_PRICE DECIMAL;
	
	DECLARE CUR_PRODUCT CURSOR
	FOR
		SELECT PROD_NAME, PRICE
		FROM PRODUCT;

	OPEN CUR_PRODUCT;

	FETCH NEXT FROM CUR_PRODUCT INTO
		@PRODUCT_NAME,
		@PRODUCT_PRICE;

	WHILE @@FETCH_STATUS = 0
		BEGIN
			PRINT @PRODUCT_NAME + '--' + CAST(@PRODUCT_PRICE AS VARCHAR);
			FETCH NEXT FROM CUR_PRODUCT INTO
				@PRODUCT_NAME,
				@PRODUCT_PRICE;
		END;
	CLOSE CUR_PRODUCT;*/



/*CREATE TRIGGER TRG_INSERT_PRODUCT
ON PRODUCT
AFTER INSERT
AS
BEGIN
	PRINT 'NEW PRODUCT ADDED';
END;

INSERT INTO PRODUCT VALUES('EL15', 'MOBILE', 'SAMSUNG', 600);

SELECT * FROM ORDER1*/


/*CREATE TRIGGER TRG_INSERT_ORDER
ON ORDERS
AFTER INSERT
AS
BEGIN
DECLARE @PRODUCT_ID VARCHAR(8);
set @PRODUCT_ID =(select prod_id from inserted)
PRINT 'NEW ORDER RECEIVED ' + @PRODUCT_ID;
END;

INSERT INTO ORDERS VALUES('ORD15', '12-Aug-2021', 'NEW', 'EL1O1');


SELECT * FROM ORDER1*/


--Day5
--use mars_new;

/*DECLARE @PRODUCT_DATA TABLE(
	PROD_NAME VARCHAR(MAX) NOT NULL,
	PROD_DESC VARCHAR(MAX) NOT NULL,
	PRICE DECIMAL(8,2) NOT NULL
);

INSERT INTO @PRODUCT_DATA
SELECT
	PROD_NAME,
	PROD_DESC,
	PRICE
FROM
	PRODUCT

SELECT * FROM @PRODUCT_DATA; */


/*CREATE FUNCTION udfNetSale(
	@quantity int,
	@price desc(10,2),
	@discount desc(4,2)
)
return des(10,2)
as
begin
	return @quantity * price *(1-@discount);
end;

select dbo.udfNetSale(10,100,0.1) as net_value */


create function udfProductWithSameDesc(
	@product_desc varchar(max)
)
returns table
as
return
	select
		prod_name,
		prod_desc,
		price
	from
		product
	where
		prod_desc = @product_desc;

select * from dbo.udfProductWithSameDesc('DELL');

--for interview practice about Sql injection
select * from product where 1 =1;
select * from product where prod_id ='EL105' or 1 = 1;