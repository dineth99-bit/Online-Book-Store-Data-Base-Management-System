CREATE DATABASE Online_Bookshop;

CREATE TABLE CUSTOMER(
Customer_id varchar(10) NOT NULL,
Customer_Name varchar(20) NOT NULL,
Gender varchar(6) NOT NULL,
Email_Address varchar(30),
User_Name varchar(20),
Phone_Number int(15) NOT NULL,
Additional_Phone_Number INT(15),
Country Varchar(20) NOT NULL,
PRIMARY KEY (Customer_id) 
);

SELECT * FROM Online_Bookshop.customer;

CREATE TABLE AVAILABILITY_STATUS(
Book_id varchar(10) NOT NULL,
Book_Status varchar(20) NOT NULL,
Available_Quantity varchar(10) NOT NULL,
PRIMARY KEY (Book_id) 
);

SELECT * FROM Online_Bookshop.availability_status;

CREATE TABLE HARD_COPY_BOOKS(
Book_id varchar(10) NOT NULL,
Book_Title varchar(20) NOT NULL,
Price int(6) NOT NULL,
Page_Size int(6) NOT NULL,
PRIMARY KEY (Book_id) 
);

ALTER TABLE hard_copy_books
MODIFY COLUMN Book_Title varchar(70) NOT NULL;

ALTER TABLE HARD_COPY_BOOKS
DROP PRIMARY KEY;

CREATE TABLE SOFT_COPY_BOOKS(
Book_id varchar(10) NOT NULL,
Book_name varchar(20) NOT NULL,
Price int(6) NOT NULL,
Download_option varchar(30) NOT NULL 
);

ALTER TABLE soft_copy_books
MODIFY COLUMN Book_name varchar(70) NOT NULL;

CREATE TABLE BILL(
Bill_number INT(20) NOT NULL,
Bill_status varchar(10) NOT NULL,
Bill_type VARCHAR(10) NOT NULL,
Bill_date date DEFAULT '2022-01-01',
Bill_time time DEFAULT '00:00:00',
PRIMARY KEY (BILL_NUMBER) 
);

CREATE TABLE PAYMENTS(
Payment_id varchar(20) NOT NULL,
Payment_amount int(10) NOT NULL,
Payment_date date DEFAULT '2022-01-01',
Discount_amount int(10) not NULL,
PRIMARY KEY (Payment_id) 
);

ALTER TABLE PAYMENTS
ADD Bill_No INT NOT NULL;

ALTER TABLE PAYMENTS
MODIFY COLUMN BILL_NO VARCHAR(20);

ALTER TABLE PAYMENTS
MODIFY COLUMN BILL_NO INT;

CREATE TABLE ORDERS(
Order_id varchar(20) NOT NULL,
Order_amount int(10) NOT NULL,
Order_status VARCHAR(20) not NULL,
PRIMARY KEY (Order_id) 
);

CREATE TABLE AUTHOR(
Author_name varchar(20) NOT NULL,
Author_address_line1 varchar(20) NOT NULL,
Author_address_line2 VARCHAR(20) NOT NULL,
Author_country varchar(20),
Prefer_category varchar(20) NOT NULL,
Published_count int(10)
);

ALTER TABLE author
DROP COLUMN Author_address_line2;

CREATE TABLE PRODUCT(
Product_id varchar(20) NOT NULL,
Title varchar(20) NOT NULL,
Product_version varchar(10) NOT NULL,
Product_language varchar(20) NOT NULL,
Released_date date DEFAULT '2022-10-01',
PRIMARY KEY (Product_id) 
);

ALTER TABLE product
MODIFY COLUMN Title varchar(70) NOT NULL;

CREATE TABLE SHIPMENT(
Shipment_id varchar(20) NOT NULL,
Shipment_track_number varchar(20) NOT NULL,
Shipment_method varchar(20) NOT NULL,
Shipment_sent_date date DEFAULT '2022-06-01',
Shipment_received_date date DEFAULT '2022-07-01',
Delivery_distance int(20),
PRIMARY KEY (Shipment_id) 
);

CREATE TABLE CUSTOMER_PAYMENT_METHOD(
Customer_payment_id varchar(20) NOT NULL,
Payment_method varchar(20) NOT NULL,
Security_code Binary(6) DEFAULT 010101,
PRIMARY KEY (Customer_payment_id) 
);




ALTER TABLE CUSTOMER_PAYMENT_METHOD
DROP COLUMN SECURITY_CODE;

ALTER TABLE CUSTOMER_PAYMENT_METHOD
ADD Customer_id varchar(20);

ALTER TABLE CUSTOMER_PAYMENT_METHOD
DROP COLUMN Customer_id;

ALTER TABLE CUSTOMER_PAYMENT_METHOD
ADD Customer_id varchar(20);

ALTER TABLE CUSTOMER_PAYMENT_METHOD
ADD CONSTRAINT fk1_const
FOREIGN KEY(Customer_id) REFERENCES CUSTOMER(Customer_id)
ON DELETE SET null ON UPDATE cascade;

SHOW CREATE TABLE CUSTOMER_PAYMENT_METHOD;

ALTER TABLE PAYMENTS
ADD Customer_payment_id varchar(20);


SHOW CREATE TABLE CUSTOMER_PAYMENT_METHOD;

ALTER TABLE CUSTOMER
ADD Author_id varchar(20);

ALTER TABLE CUSTOMER
ADD CONSTRAINT fk2_const
FOREIGN KEY(Author_id) REFERENCES CUSTOMER(Customer_id)
ON DELETE SET null ON UPDATE cascade;

ALTER TABLE ORDERS
ADD Customer_id varchar(20);

ALTER TABLE ORDERS
ADD CONSTRAINT fk3_const
FOREIGN KEY(Customer_id) REFERENCES CUSTOMER(Customer_id)
ON DELETE SET null ON UPDATE cascade;

ALTER TABLE SHIPMENT
ADD Package_number varchar(20);

ALTER TABLE SHIPMENT
ADD CONSTRAINT fk4_const
FOREIGN KEY(Package_number) REFERENCES ORDERS(Order_id)
ON DELETE SET null ON UPDATE cascade;

ALTER TABLE BILL
ADD Payment_id varchar(20);

ALTER TABLE BILL
ADD CONSTRAINT fk5_const
FOREIGN KEY(Payment_id) REFERENCES ORDERS(Order_id)
ON DELETE SET null ON UPDATE cascade;

ALTER TABLE BILL
ADD CONSTRAINT fk6_const
FOREIGN KEY(Payment_id) REFERENCES PAYMENTS(Payment_id)
ON DELETE SET null ON UPDATE cascade;

ALTER TABLE PAYMENTS
ADD CONSTRAINT fk7_const
FOREIGN KEY(Customer_payment_id) REFERENCES CUSTOMER_PAYMENT_METHOD(Customer_payment_id)
ON DELETE SET null ON UPDATE cascade;



ALTER TABLE SOFT_COPY_BOOKS
ADD Product_id varchar(20);

ALTER TABLE SOFT_COPY_BOOKS
ADD CONSTRAINT fk9_const
FOREIGN KEY(Product_id) REFERENCES PRODUCT(Product_id)
ON DELETE SET null ON UPDATE cascade;

ALTER TABLE AUTHOR
ADD Author_id varchar(20);

ALTER TABLE AUTHOR
ADD UNIQUE (Author_id); 

ALTER TABLE SOFT_COPY_BOOKS
DROP COLUMN Book_id;

ALTER TABLE SOFT_COPY_BOOKS
ADD Book_id varchar(20);

ALTER TABLE SOFT_COPY_BOOKS
ADD CONSTRAINT fk10_const
FOREIGN KEY(Book_id) REFERENCES AUTHOR(Author_id)
ON DELETE SET null ON UPDATE cascade;

ALTER TABLE HARD_COPY_BOOKS
DROP COLUMN Book_id;

ALTER TABLE HARD_COPY_BOOKS
ADD Book_id varchar(20);

ALTER TABLE HARD_COPY_BOOKS
ADD CONSTRAINT fk11_const
FOREIGN KEY(Book_id) REFERENCES AUTHOR(Author_id)
ON DELETE SET null ON UPDATE cascade;

ALTER TABLE HARD_COPY_BOOKS
ADD Product_id varchar(20);

ALTER TABLE HARD_COPY_BOOKS
ADD CONSTRAINT fk12_const
FOREIGN KEY(Product_id) REFERENCES PRODUCT(Product_id)
ON DELETE SET null ON UPDATE cascade;

ALTER TABLE HARD_COPY_BOOKS
ADD CONSTRAINT fk13_const
FOREIGN KEY(Book_id) REFERENCES AVAILABILITY_STATUS(Book_id)
ON DELETE SET null ON UPDATE cascade;

SHOW CREATE TABLE HARD_COPY_BOOKS;

ALTER TABLE shipment
DROP PRIMARY KEY;

ALTER TABLE shipment
ADD CONSTRAINT pk1_const PRIMARY KEY(Shipment_id , Shipment_track_number);

ALTER TABLE author
ADD CONSTRAINT pk2_const PRIMARY KEY(Author_id);

Alter table SOFT_COPY_BOOKS
Drop FOREIGN KEY fk10_const;

Alter table hard_copy_books
Drop FOREIGN KEY fk11_const;

ALTER TABLE author
DROP PRIMARY KEY;

ALTER TABLE AUTHOR
DROP COLUMN Author_id;

ALTER TABLE AUTHOR
ADD Author_id varchar(20);

ALTER TABLE author
ADD CONSTRAINT fk20_const
FOREIGN KEY(Author_id) REFERENCES PRODUCT(Product_id)
ON DELETE SET null ON UPDATE cascade;

ALTER TABLE bill
DROP COLUMN Bill_type;

ALTER TABLE CUSTOMER
DROP COLUMN Customer_Name;

ALTER TABLE CUSTOMER
ADD First_Name varchar(20) NOT NULL;

ALTER TABLE CUSTOMER
ADD Last_Name varchar(20) NOT NULL;

ALTER TABLE customer
ADD street_Number varchar(20) NOT NULL;

ALTER TABLE customer
ADD City varchar(20) NOT NULL;


CREATE TABLE PREFERENCES(
Author_id varchar(20) NOT NULL,
Author_name varchar(20) NOT NULL,
Prefer_category varchar(20) NOT NULL

);

INSERT INTO CUSTOMER
VALUES('1101','Male','nim@gmail.com','Nimal990'	,'776767890','312245678','SriLanka','1101','Nimal','Perera','23','kandana');
INSERT INTO CUSTOMER
VALUES('1102','Female','Kam@gmal.com','kamala766','712543865','312256789','SriLanka',null,'Kamala','Costa','12','Colombo');
INSERT INTO CUSTOMER
VALUES('1201','Male','sun@gmail.com','sun567','762948765','345678912','Australia','1201','Sunil','Fernando','34','Matara');
INSERT INTO CUSTOMER
VALUES('1202','Male','paw@gmail.com','paw245','741025987','312278456','France','1202','Pawan','Silva','54','Galle');
INSERT INTO CUSTOMER
VALUES('1301','Male','lay@gmail.com','lay678','778912563','312209873','USA',null,'Layan','Perera','10','Kandy');
INSERT INTO CUSTOMER
VALUES('1302','Male','Gay@gmail.com','Gay123','778342256','312267873','USA',null,'Gayan','Perera','12','Matara');

UPDATE CUSTOMER
SET Email_Address =  'Gay@gmail12.com', User_Name = 'Gay234' , Country = 'Russia'
where Customer_id = '1302' ;

UPDATE CUSTOMER
SET First_Name =  'Layashan', User_Name = 'Lay1455' , Country = 'Egypt'
where Customer_id = '1301' ;

DELETE FROM CUSTOMER
WHERE Customer_ID = '1302';

select * from customer;



INSERT INTO availability_status
VALUES('H101','Yes','2');
INSERT INTO availability_status
VALUES('H102','No','0');
INSERT INTO availability_status
VALUES('H103','No','0');
INSERT INTO availability_status
VALUES('H104','Yes','5');
INSERT INTO availability_status
VALUES('H105','Yes','6');

select * from availability_status;




INSERT INTO product
VALUES('P101','A PASSAGE TO INDIA','1','English','2021-02-01');
INSERT INTO product
VALUES('P102','HENDERSON THE RAIN KING','1','English','2021-03-01');
INSERT INTO product
VALUES('P103','THE HEART IS A LONELY HUNTER','2','English','2020-04-01');
INSERT INTO product
VALUES('P104','THE GRAPES OF WRATH','2','English','2020-05-01');
INSERT INTO product
VALUES('P105','A PORTRAIT OF THE ARTIST AS A YOUNG MAN','1','English','2021-06-01');
INSERT INTO product
VALUES('P106','BRAVE NEW WORLD','3','English','2019-07-01');
INSERT INTO product
VALUES('P107','DARKNESS AT NOON','4','English','2018-08-01');
INSERT INTO product
VALUES('P108','UNDER THE VOLCANO','4','English','2018-09-01');

select * from product;

INSERT INTO hard_copy_books
VALUES('A PASSAGE TO INDIA','1750','400','H101','P101');
INSERT INTO hard_copy_books
VALUES('HENDERSON THE RAIN KING','2000','500','H102','P102');
INSERT INTO hard_copy_books
VALUES('THE HEART IS A LONELY HUNTER','3000','900','H103','P103');
INSERT INTO hard_copy_books
VALUES('THE GRAPES OF WRATH','3250','250','H104','P104');
INSERT INTO hard_copy_books
VALUES('A PORTRAIT OF THE ARTIST AS A YOUNG MAN','3000','900','H105','P105');
INSERT INTO hard_copy_books
VALUES('A PORTRAIT OF THE ARTIST AS A YOUNG MAN','3000','900','H105','P105');
DELETE FROM hard_copy_books
WHERE Book_id = 'H105';
INSERT INTO hard_copy_books
VALUES('A PORTRAIT OF THE ARTIST AS A YOUNG MAN','3000','900','H105','P105');


select * from hard_copy_books;



INSERT INTO soft_copy_books
VALUES('A PASSAGE TO INDIA','1750','Email','P101','S101');
INSERT INTO soft_copy_books
VALUES('HENDERSON THE RAIN KING','2000','Email','P102','S102');
INSERT INTO soft_copy_books
VALUES('BRAVE NEW WORLD','2400','Google Drive','P106','S106');
INSERT INTO soft_copy_books
VALUES('DARKNESS AT NOON','1900','Google Drive','P107','S107');
INSERT INTO soft_copy_books
VALUES('UNDER THE VOLCANO','5600','Google Drive','P108','S108');

select * from soft_copy_books;




INSERT INTO author
VALUES('Damian','kandana','Sri Lanka','Sci-fic','10','P101');
INSERT INTO author
VALUES('Peter','Colombo','Japan','Fantasy','3','P102');
INSERT INTO author
VALUES('Laren','Matara','USA','Adventure','8','P103');
INSERT INTO author
VALUES('John','Galle','China','Horror','7','P104');
INSERT INTO author
VALUES('Cibil','Kandy','Japan','Thriller','5','P105');
INSERT INTO author
VALUES('Marco','Matara','India','History','24','P106');
INSERT INTO author
VALUES('Zyril','Jaela','Sri Lanka','Travel','1','P107');
INSERT INTO author
VALUES('Ahamed','Hapugala','Japan','Art','6','P108');

select * from author;


INSERT INTO orders
VALUES('1A','1750','confirmed','1101');
INSERT INTO orders
VALUES('2A','2000','confirmed','1102');
INSERT INTO orders
VALUES('3B','3000','confirmed','1201');
INSERT INTO orders
VALUES('3A','3250','confirmed','1202');
INSERT INTO orders
VALUES('4A','3000','confirmed','1301');
INSERT INTO orders
VALUES('1D','1750','confirmed','1101');
INSERT INTO orders
VALUES('2B','3000','Confirmed','1102');
INSERT INTO orders
VALUES('3C','3400','Confirmed','1101');

select * from orders;

INSERT INTO customer_payment_method
VALUES('P111A','Visa card','1101');
INSERT INTO customer_payment_method
VALUES('p112A','Master Card','1102');
INSERT INTO customer_payment_method
VALUES('p121','Paypal','1201');
INSERT INTO customer_payment_method
VALUES('p122','Helapay','1202');
INSERT INTO customer_payment_method
VALUES('p131','Paypal','1301');
INSERT INTO customer_payment_method
VALUES('p111B','Master card','1101');
INSERT INTO customer_payment_method
VALUES('P112B','Paypal','1102');

select * from customer_payment_method;

INSERT INTO payments
VALUES('1A','3000','2022-08-09','5','111','P111A');
INSERT INTO payments
VALUES('2A','2000','2022-09-09','5','112','p112A');
INSERT INTO payments
VALUES('3B','1000','2022-10-09','6','113','p121');
INSERT INTO payments
VALUES('3A','1500','2022-11-09','5','114','p122');
INSERT INTO payments
VALUES('4A','2500','2022-12-09','7','115','p131');
INSERT INTO payments
VALUES('1D','2200','2022-09-13','5','116','p111B');
INSERT INTO payments
VALUES('2B','4500','2022-09-14','5','117','P112B');
INSERT INTO payments
VALUES('3C','2300','2022-09-15','5','118','P122');

select * from payments;

INSERT INTO bill
VALUES('111','paid','2022-08-09','00:09:00','1A');
INSERT INTO bill
VALUES('112','Not Paid','2022-09-09','00:10:00','2A');
INSERT INTO bill
VALUES('113','paid','2022-10-09','00:11:00','3B');
INSERT INTO bill
VALUES('114','paid','2022-11-09','00:12:00','3A');
INSERT INTO bill
VALUES('115','Not Paid','2022-12-09','00:13:00','4A');
INSERT INTO bill
VALUES('117','Not Paid','2022-09-14','00:15:00','2B');

select * from bill;

INSERT INTO shipment
VALUES('EST666','4','Air','2022-09-07','2022-11-07','200','1A');
INSERT INTO shipment
VALUES('ASN777','5','Air','2022-08-09','2022-11-08','50','2A');
INSERT INTO shipment
VALUES('EST123','6','sea','2022-09-09','2022-11-09','51','3B');
INSERT INTO shipment
VALUES('EST567','7','Air','2022-09-10','2022-11-10','52','3A');
INSERT INTO shipment
VALUES('ASN999','8','sea','2022-09-11','2022-11-11','53','4A');
INSERT INTO shipment
VALUES('EST444','9','Air','2022-09-12','2022-11-12','54','1D');
INSERT INTO shipment
VALUES('ASN700','10','sea','2022-09-13','2022-11-13','55','2B');

select * from shipment;

alter table author
drop column Prefer_category;

alter table preferences
drop COLUMN Author_name;

alter table preferences
drop column Author_id;

ALTER TABLE preferences
ADD Customer_id varchar(20);

alter table preferences
add constraint pk_pref primary key ( Customer_id  , prefer_category );

ALTER TABLE preferences
ADD CONSTRAINT fk22_customer
FOREIGN KEY (Customer_id) REFERENCES customer(Customer_id)
ON DELETE cascade ON UPDATE cascade;

INSERT INTO preferences
VALUES('Science-Fic','1101');
INSERT INTO preferences
VALUES('Fantasy','1102');
INSERT INTO preferences
VALUES('Adventure','1201');
INSERT INTO preferences
VALUES('Horror','1202');
INSERT INTO preferences
VALUES('Thriller','1301');
INSERT INTO preferences
VALUES('Fantasy','1101');
INSERT INTO preferences
VALUES('Horror','1102');
INSERT INTO preferences
VALUES('Horror','1101');

select * from preferences;


-- ############################### Simple Queries ##############################################

-- #select,project,cartesian product,user view,renaming,aggrgate(avg,min,max),like

-- # 1) select operation
-- select * from online_bookshop.customer;

-- select * from online_bookshop.customer 
-- where Customer_id = '1101';

-- # 2) project operation
-- select Book_Title , Price from hard_copy_books;

-- # 3) product
-- select * from hard_copy_books CROSS JOIN soft_copy_books; 

-- select * from customer CROSS JOIN author; 

-- # 4) user view

-- create view user1 as select Customer_id,First_Name from customer;
-- select * from user1;

-- # 5) renaming

-- ALTER TABLE customer
-- CHANGE Customer_id Customer_id_present varchar(20);

-- ALTER TABLE customer RENAME customer1;
-- ALTER TABLE customer1 RENAME customer;

-- # 6) aggregate

-- SELECT Book_ID, count(Book_ID) as No_of_Books, avg(price) as Average_Price
-- FROM hard_copy_books group by Book_ID;

-- select * from hard_copy_books where Price = (select MAX(price) FROM hard_copy_books);

-- # 7) Like

-- SELECT Product_id, Product_version FROM product
-- WHERE ( (Released_date like '2021-__-__') );


-- ############################### Complex Queries ##############################################

-- #use aliasing in every table (rename)

-- # 4 should demonstrate basic set operations (union, intersection, set difference, division) without user views

-- # 1) Union only

-- (select First_Name as Name , Phone_Number as Tele_No 
-- from customer where country = 'SriLanka')
-- UNION
-- (select First_Name as Name , Phone_Number as Tele_No 
-- from customer where Last_Name = 'Perera');

-- # 2) Intersection only

-- SELECT a.Author_id , a.Author_country
-- FROM author as a inner join product as p
-- ON a.Author_ID = p.Product_id
-- NATURAL JOIN hard_copy_books as h
-- WHERE h.Page_Size = 900 ;


-- #3) set difference

-- SELECT C.Customer_id as Cus_ID
-- FROM customer as C
-- WHERE Customer_id  NOT IN (select Author_id from author);

-- #4) Division

-- SELECT DISTINCT customer_id FROM customer
-- WHERE customer_id NOT IN (                                  

--     SELECT CR.customer_id                                 
--     FROM (                                      

--         SELECT preferences.Prefer_category, R2.customer_id                      
--         FROM preferences                                
--         CROSS JOIN (                          

--             SELECT DISTINCT customer_id FROM customer          
--         ) AS R2                               
--     ) AS CR                                     
--     WHERE NOT EXISTS (
--         SELECT *
--         FROM customer
--         WHERE Prefer_category = CR.Prefer_category AND customer.customer_id = CR.customer_id
--     )
-- );


-- # inner join, natural join, left outer join, right outer join, full outer join, outer union

-- # 5) Natural join

-- CREATE view User_view1 AS ( select * from preferences);
-- CREATE view User_view2 AS ( select * from customer);
-- select * from User_view1 as U_V_1 Natural join User_view2 as U_V_2 WHERE ( U_V_2 .Country = 'SriLanka');


-- #6) inner join

-- CREATE view User_view3 AS ( select * from Author);
-- CREATE view User_view4 AS ( select Product_id,Title,Product_version from product);

-- select * from User_view3 as U_V_3 inner join User_view4 as U_V_4 
-- on U_V_3.Author_id =  U_V_4.Product_id
-- where ( U_V_4.Product_version = 1);

-- #7 ) left outer join

-- CREATE view User_view5 AS ( select * from shipment);
-- CREATE view User_view6 AS ( select Order_id, Order_amount, Order_status from orders);

-- select * from User_view5 as U_V_5 LEFT outer join User_view6 as U_V_6 
-- on U_V_5.Package_number =  U_V_6.Order_id
-- where ( U_V_6. Order_amount > 2900);

-- #8 ) right outer join

-- CREATE view User_view5 AS ( select * from shipment);
-- CREATE view User_view6 AS ( select Order_id, Order_amount, Order_status from orders);

-- select * from User_view5 as U_V_5 right outer join User_view6 as U_V_6 
-- on U_V_5.Package_number =  U_V_6.Order_id
-- where ( U_V_6. Order_amount > 2900);

-- #9) full outer join

-- create view Right_Outer_view As (select * from User_view5 as U_V_5 right outer join User_view6 as U_V_6 
-- on U_V_5.Package_number =  U_V_6.Order_id where ( U_V_6. Order_amount > 2900) );

-- create view Left_Outer_view As (select * from User_view5 as U_V_5 right outer join User_view6 as U_V_6 
-- on U_V_5.Package_number =  U_V_6.Order_id where ( U_V_6. Order_amount > 2900) );

-- select * from Right_Outer_view union select * from Left_Outer_view;

-- #10) outer union

-- create view Outer_union_view as ( (select * from customer as C NATURAL JOIN preferences as p) 
-- Union (select C.Customer_id, C.Gender, C.Email_Address, C.User_Name, C.Phone_Number, C.Additional_Phone_Number, C.Country, 
-- C.Author_id, C.First_Name, C.Last_Name, C.street_Number, C.City,NULL FROM customer as C ) );

-- select * from Outer_union_view;

-- # Nested  queries

-- #11) union with nested select

-- select * from ( ( select Bill_number as Bill_num , payment_id as pay_id from bill) 
-- UNION ( select Customer_id as cus_id , user_name as use_nm  from customer) ) as d
-- inner join payments as p on p.BILL_NO = d.Bill_num;

-- #12 ) select complex query

-- select p.Product_id , p.Title, p.product_version from product as p
-- where p.Product_id IN ( select h.Product_id from hard_copy_books as h where h.Page_Size > 499 );

-- #13) 

-- select Customer_id , count(O.Order_id) as Order_count , Order_status as order_stat
-- from
-- ( select Customer_id , First_Name from customer) as c
-- natural join
-- ( select  Customer_id , Order_status, Order_id  from orders ) as O
-- GROUP BY Customer_id;

-- ############################################ Indexing ##############################################

-- #1) Tunning the complex query (union)

-- show index from customer;

-- explain ( (select First_Name as Name , Phone_Number as Tele_No 
-- from customer where country = 'SriLanka')
-- UNION
-- (select First_Name as Name , Phone_Number as Tele_No 
-- from customer where Last_Name = 'Perera'));

-- CREATE INDEX country_ind ON customer(country);

-- Drop INDEX country_ind ON customer;

-- #2) Tunning the complex query (intersection)

-- show index from author;

-- explain ( SELECT a.Author_id , a.Author_country
-- FROM author as a inner join product as p
-- ON a.Author_id = p.Product_id
-- NATURAL JOIN hard_copy_books as h
-- WHERE h.Page_Size = 900 );

-- CREATE INDEX author_ind ON author(country);

-- Drop INDEX author_ind ON author;
--  
-- #3) set difference

-- show index from author;

-- explain ( SELECT C.Customer_id as Cus_ID
-- FROM customer as C
-- WHERE Customer_id  NOT IN (select Author_id  from author) );

-- CREATE INDEX custind1 ON customer(Customer_ID);

-- Drop index custind1 ON customer;

-- #4) Natural join


-- explain(select * from User_view1 as U_V_1 Natural join User_view2 as U_V_2 WHERE ( U_V_2 .Country = 'SriLanka'));

-- show index from preferences;

-- CREATE INDEX prefind ON customer(Country);

-- Drop index prefind ON customer;

-- #5 ) inner join

-- explain(select * from User_view3 as U_V_3 inner join User_view4 as U_V_4 
-- on U_V_3.Author_id =  U_V_4.Product_id
-- where ( U_V_4.Product_version = 1));

-- CREATE INDEX index_10 ON product(Product_version);

-- drop index index_10 on product;


-- #6) left outer join


-- explain( select * from User_view5 as U_V_5 LEFT outer join User_view6 as U_V_6 
-- on U_V_5.Package_number =  U_V_6.Order_id
-- where ( U_V_6. Order_amount > 2900));

-- CREATE INDEX pack_num ON orders(Order_amount);

-- drop index pack_num ON orders;

-- #7) full outer join

-- explain(select * from Right_Outer_view union select * from Left_Outer_view);
-- show index from orders;
-- drop index pack_num ON orders;
-- CREATE INDEX pack_num ON orders(Order_amount);

-- #8) nested 

-- explain(select * from ( ( select Bill_number as Bill_num , payment_id as pay_id from bill) 
-- UNION ( select Customer_id as cus_id , user_name as use_nm  from customer) ) as d
-- inner join payments as p on p.BILL_NO = d.Bill_num);

-- show index from bill;
-- show index from customer;

-- create index Bill_num_index on bill(Bill_number);
-- drop index Bill_num_index on bill;

-- #9) nested 2

-- explain (select p.Product_id , p.Title, p.product_version from product as p
-- where p.Product_id IN ( select h.Product_id from hard_copy_books as h where h.Page_Size > 499 ));

-- create index Page_num_index on hard_copy_books(Page_Size);
-- show index from hard_copy_books;
-- drop index Page_num_index on hard_copy_books;


-- #10) nested 3

-- explain ( select Customer_id , count(O.Order_id) as Order_count , Order_status as order_stat
-- from
-- ( select Customer_id , First_Name from customer) as c
-- natural join
-- ( select  Customer_id , Order_status, Order_id  from orders ) as O
-- GROUP BY Customer_id);


-- create index Customer_id_index on customer(Customer_id);
-- show index from customer;

-- drop index Customer_id_index on customer;





