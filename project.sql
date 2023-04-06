DROP TABLE branch;
DROP TABLE loan;
DROP TABLE customer;
DROP TABLE employee;
DROP TABLE payment;
DROP TABLE account;
DROP TABLE credit_card;
DROP TABLE depositor;
DROP TABLE borrower;
DROP TABLE customer_banker;
DROP TABLE transactions;



CREATE TABLE branch(
	branch_code varchar(10) PRIMARY KEY,
	branch_name text UNIQUE,
	branch_city text NOT NULL
);

CREATE TABLE loan (
	loan_id int PRIMARY KEY,
	loan_amount numeric(10,2) CHECK(loan_amount>0),
	loan_type varchar(30) NOT NULL,
	loan_duration_months int NOT NULL, 
	interest_rate numeric(4,2) NOT NULL,
	monthly_payment numeric(10,2),
	branch_code varchar(10) REFERENCES branch (branch_code),
	total_payable_amount numeric(10,2),
	date_of_creation date NOT NULL
);


CREATE TABLE customer(
	customer_id int PRIMARY KEY,
	first_name varchar(30) NOT NULL,
	last_name varchar(30) NOT NULL,
	birth_date date NOT NULL,
	street_name varchar(20)NOT NULL,
	city_name varchar(20) NOT NULL ,
	state_name varchar(25)NOT NULL,
	email_id varchar(30) NOT NULL
);

CREATE TABLE employee (
	employee_id int PRIMARY KEY,  
	employee_name varchar(30) UNIQUE, 
	employee_role varchar(30) NOT NULL,
	salary numeric(10,2) CHECK(salary>0),
	mobile_number varchar(10) UNIQUE,
	birth_date date NOT NULL,
	hire_date date NOT NULL,  
	branch_code varchar(20) REFERENCES branch (branch_code)
);

CREATE TABLE payment (
	payment_id int NOT NULL,
	payment_amount numeric(10,2) NOT NULL,
	payment_date date NOT NULL,
	loan_id int REFERENCES loan (loan_id),
	PRIMARY KEY (payment_id,loan_id)
);

CREATE TABLE account(
	account_id bigint PRIMARY KEY,
	account_type varchar(20) NOT NULL,
	balance numeric(10,2),
	last_updated timestamp DEFAULT current_timestamp NOT NULL,
	branch_code varchar(10) REFERENCES branch(branch_code)
);

CREATE TABLE credit_card (
	credit_card_number varchar(20) PRIMARY KEY,
	credit_limit numeric(10,2) NOT NULL,
	customer_id int REFERENCES customer (customer_id)
);

CREATE TABLE depositor (
	customer_id int NOT NULL,
	account_id bigint NOT NULL,
	access_date date NOT NULL,
	FOREIGN KEY (customer_id) REFERENCES customer (customer_id),
	FOREIGN KEY (account_id) REFERENCES account (account_id),
	PRIMARY KEY (customer_id,account_id)
);

CREATE TABLE borrower (
	customer_id int NOT NULL,
	loan_id int NOT NULL,
	FOREIGN KEY (customer_id) REFERENCES customer (customer_id),
	FOREIGN KEY (loan_id) REFERENCES loan (loan_id),
	PRIMARY KEY(customer_id,loan_id)
);

CREATE TABLE customer_banker (
	employee_id int NOT NULL,
	customer_id int NOT NULL,
	FOREIGN KEY (employee_id) REFERENCES employee (employee_id),
	FOREIGN KEY (customer_id) REFERENCES customer (customer_id),
	PRIMARY KEY (customer_id,employee_id)
);

CREATE TABLE transactions(
	trans_id serial PRIMARY KEY,
	account_id bigint REFERENCES account(account_id),
	amount numeric(10,2) CHECK(amount>0),
	trans_type varchar(20) NOT NULL CHECK(trans_type= 'Deposit' or trans_type='Withdrawal' OR trans_type='Amt_sent' OR trans_type='Amt_received'),
	remaining_balance numeric(10,2) NOT NULL,
	date_time_trans timestamp DEFAULT current_timestamp NOT NULL
);

INSERT INTO customer (customer_id, first_name, last_name, birth_date, street_name, city_name, state_name, email_id) VALUES (101, 'Kiran', 'Kumar','1988-05-12', 'Vidyanagar', 'Hyderabad', 'Telangana', 'kirankumar@gmail.com');
INSERT INTO customer (customer_id, first_name, last_name, birth_date, street_name, city_name, state_name, email_id) VALUES (102, 'Rahul', 'Mehta', '1990-09-02', 'Kukatpally', 'Hyderabad', 'Telangana','rahulmehta02@gmail.com');
INSERT INTO customer (customer_id, first_name, last_name, birth_date, street_name, city_name, state_name, email_id) VALUES (103, 'Nandan', 'Mohan', '1984-12-09', 'Jublie Hills', 'Hyderabad', 'Telangana', 'nandanmohan1984@gmail.com');
INSERT INTO customer (customer_id, first_name, last_name, birth_date, street_name, city_name, state_name, email_id) VALUES (104, 'Lakshana', 'kolur', '1998-05-15', 'Rajaj Nagar Colony', 'Warangal', 'Telangana','lakshanakolour@gmail.com');
INSERT INTO customer (customer_id, first_name, last_name, birth_date, street_name, city_name, state_name, email_id) VALUES (105, 'Mohan', 'Kumar', '1988-05-15', 'Rajendra Nagar', 'Medak', 'Telangana','mohankumar1505@gmail.com');
INSERT INTO customer (customer_id, first_name, last_name, birth_date, street_name, city_name, state_name, email_id) VALUES (106, 'Meghana','Singh', '1996-06-12', 'Ayodhya Nagar', 'Nizambad', 'Telangana', 'meghanasingh1996@gmail.com');
INSERT INTO customer (customer_id, first_name, last_name, birth_date, street_name, city_name, state_name, email_id) VALUES (107, 'Ranjdeep', 'Mamtani', '1965-06-19', 'Uppal', 'Hyderabad', 'Telangana', 'rajdeepmamtani06@gmail.com');
INSERT INTO customer (customer_id, first_name, last_name, birth_date, street_name, city_name, state_name, email_id) VALUES (108, 'Sonal', 'Singh', '1989-12-02', 'Mahathma Nagar', 'Karimnagar', 'Telangana', 'sonalsingh@gmail.com');
INSERT INTO customer (customer_id, first_name, last_name, birth_date, street_name, city_name, state_name, email_id) VALUES (109, 'Jayashree','Kumari','1990-11-12', 'Mehedipatnam' ,'Hyderabad', 'Telangana', 'jayashreekumari1211@gmail.com');
INSERT INTO customer (customer_id, first_name, last_name, birth_date, street_name, city_name, state_name, email_id) VALUES (110, 'Abhilasha','Somani', '1977-05-01', 'Market road', 'Nalgonda', 'Telangana', 'abhilashasomani007@gmail.com');


INSERT INTO branch (branch_code, branch_name, branch_city) VALUES ('HYD0001','Vidyanagar Branch','Hyderabad');
INSERT INTO branch (branch_code, branch_name, branch_city) VALUES ('WAR0025','Rajaj Nagar Colony Branch','Warangal');
INSERT INTO branch (branch_code, branch_name, branch_city) VALUES ('MED0155','Rajendra Nagar Branch','Medak');
INSERT INTO branch (branch_code, branch_name, branch_city) VALUES ('NAL0085','Market road Branch','Nalgonda');
INSERT INTO branch (branch_code, branch_name, branch_city) VALUES ('NIZ0109','Ayodhya Nagar Branch','Nizambad');
INSERT INTO branch (branch_code, branch_name, branch_city) VALUES ('KAR0045','Mahathma Nagar Branch','Karimnagar');

INSERT INTO loan (loan_id, loan_amount, loan_type, loan_duration_months, interest_rate, monthly_payment, branch_code, total_payable_amount,date_of_creation) VALUES (1200102, 200000, 'Equipment loan', 12,7.3, 17333, 'HYD0001',207996,'2021-12-04');
INSERT INTO loan (loan_id, loan_amount, loan_type, loan_duration_months, interest_rate, monthly_payment, branch_code, total_payable_amount,date_of_creation) VALUES (1200106, 1000000, 'House loan', 60, 4.4, 18598, 'HYD0001',1115880,'2020-04-21');
INSERT INTO loan (loan_id, loan_amount, loan_type, loan_duration_months, interest_rate, monthly_payment, branch_code, total_payable_amount,date_of_creation) VALUES (1200108, 2000000, 'Business loan', 30, 7.2, 73046, 'HYD0001', 2191380,'2021-05-30');
INSERT INTO loan (loan_id, loan_amount, loan_type, loan_duration_months, interest_rate, monthly_payment, branch_code, total_payable_amount,date_of_creation) VALUES (1200109, 2000000, 'House loan', 32, 5.5, 67338, 'WAR0025',2154816,'2021-09-14');
INSERT INTO loan (loan_id, loan_amount, loan_type, loan_duration_months, interest_rate, monthly_payment, branch_code, total_payable_amount,date_of_creation) VALUES (1200112, 350000, 'Personal_loan', 20, 4.9, 18166, 'MED0155',363320,'2021-06-01');
INSERT INTO loan (loan_id, loan_amount, loan_type, loan_duration_months, interest_rate, monthly_payment, branch_code, total_payable_amount,date_of_creation) VALUES (1200115, 600000, 'House loan', 12, 6.2, 51861, 'NIZ0109',622332,'2022-01-15');
INSERT INTO loan (loan_id, loan_amount, loan_type, loan_duration_months, interest_rate, monthly_payment, branch_code, total_payable_amount,date_of_creation) VALUES (1200119, 5000000, 'Mortage loan', 32, 3.1, 162999, 'HYD0001',5215968,'2021-11-22');
INSERT INTO loan (loan_id, loan_amount, loan_type, loan_duration_months, interest_rate, monthly_payment, branch_code, total_payable_amount,date_of_creation) VALUES (1200120, 1500000, 'Business loan', 20, 7.5, 80019, 'KAR0045',1600380,'2021-10-30');
INSERT INTO loan (loan_id, loan_amount, loan_type, loan_duration_months, interest_rate, monthly_payment, branch_code, total_payable_amount,date_of_creation) VALUES (1200124, 1000000, 'House loan', 40,4.2, 26834, 'NAL0085',1073360,'2020-12-23');
INSERT INTO loan (loan_id, loan_amount, loan_type, loan_duration_months, interest_rate, monthly_payment, branch_code, total_payable_amount,date_of_creation) VALUES (1200126, 550000, 'Car loan', 16, 5.6, 35754, 'HYD0001',572064,'2021-08-07');


INSERT INTO account(account_id, account_type, balance, branch_code) VALUES (3982276530, 'Checking Account', 5000, 'HYD0001');
INSERT INTO account(account_id, account_type, balance, branch_code) VALUES (8902345125,'Savings Account', 60000, 'HYD0001');
INSERT INTO account(account_id, account_type, balance, branch_code) VALUES (9871702287, 'Savings Account', 70000, 'HYD0001');
INSERT INTO account(account_id, account_type, balance, branch_code) VALUES (4345010261,'Zero Balance Account', 7000, 'WAR0025');
INSERT INTO account(account_id, account_type, balance, branch_code) VALUES (9124003568, 'Checking Account', 6500, 'MED0155');
INSERT INTO account(account_id, account_type, balance, branch_code) VALUES (5189201392, 'Savings Account', 45000,'NIZ0109' );
INSERT INTO account(account_id, account_type, balance, branch_code) VALUES (8001939743,'Checking Account', 5000, 'HYD0001');
INSERT INTO account(account_id, account_type, balance, branch_code) VALUES (6829743045, 'Savings Account', 80000, 'KAR0045');
INSERT INTO account(account_id, account_type, balance, branch_code) VALUES (8028492955, 'Checking Account', 10000, 'NAL0085');
INSERT INTO account(account_id, account_type, balance, branch_code) VALUES (8027649295, 'Checking Account', 9000,'HYD0001' );
INSERT INTO account(account_id, account_type, balance, branch_code) VALUES (8175492955,'Zero Balance Account', 4000,'MED0155' );
INSERT INTO account(account_id, account_type, balance, branch_code) VALUES (8028406355,'Zero Balance Account', 6000,'HYD0001');

INSERT INTO employee (employee_id,employee_name,employee_role,salary,telephone_number,birth_date,hire_date,branch_code) VALUES(1101,'Kiran Kumar','Manager',60000,'9474563210','1988-05-12','2014-08-12','HYD0001');
INSERT INTO employee (employee_id,employee_name,employee_role,salary,telephone_number,birth_date,hire_date,branch_code) VALUES(1102,'Rahul Mehta','Officer',40000,'9745612309','1990-09-02','2016-05-18','HYD0001');
INSERT INTO employee (employee_id,employee_name,employee_role,salary,telephone_number,birth_date,hire_date,branch_code) VALUES(1103,'Lakshana Kolur','Officer',50000,'9654321098','1998-05-15','2019-10-02','WAR0025');
INSERT INTO employee (employee_id,employee_name,employee_role,salary,telephone_number,birth_date,hire_date,branch_code) VALUES(1104,'Mohan Kumar','Manager',80000,'9543210987','1988-05-15','2012-05-29','MED0155');
INSERT INTO employee (employee_id,employee_name,employee_role,salary,telephone_number,birth_date,hire_date,branch_code) VALUES(1105,'Abhilasha Somani','Officer',45000,'9432109876','1977-05-01','2002-09-30','NAL0085');
INSERT INTO employee (employee_id,employee_name,employee_role,salary,telephone_number,birth_date,hire_date,branch_code) VALUES(1106,'Amol Srivastsava','Manager',70000,'9321098765','1982-04-16','2015-01-25','NAL0085');
INSERT INTO employee (employee_id,employee_name,employee_role,salary,telephone_number,birth_date,hire_date,branch_code) VALUES(1107,'Mrinal Kumar','Officer',35000,'9210987654','1996-02-16','2018-03-03','NIZ0109');
INSERT INTO employee (employee_id,employee_name,employee_role,salary,telephone_number,birth_date,hire_date,branch_code) VALUES(1108,'Najuk Pincha','Officer',40000,'9109876543','1972-04-02','2009-09-011','KAR0045');
INSERT INTO employee (employee_id,employee_name,employee_role,salary,telephone_number,birth_date,hire_date,branch_code) VALUES(1109,'Radhika Agarwal','Manager',75000,'9098765432','1985-08-13','2009-07-19','WAR0025');
INSERT INTO employee (employee_id,employee_name,employee_role,salary,telephone_number,birth_date,hire_date,branch_code) VALUES(1110,'Debojit Agarwal','Officer',38000,'9012345678','1991-12-01','2013-05-29','HYD0001');


INSERT INTO payment (payment_id, payment_amount, payment_date, loan_id) VALUES (1210, 17333, '2022-04-04', 1200102);
INSERT INTO payment (payment_id, payment_amount, payment_date, loan_id) VALUES (1211, 18598, '2022-04-21', 1200106);
INSERT INTO payment (payment_id, payment_amount, payment_date, loan_id) VALUES (1212, 73046, '2022-04-30', 1200108);
INSERT INTO payment (payment_id, payment_amount, payment_date, loan_id) VALUES (1213, 67338, '2022-04-14', 1200109);
INSERT INTO payment (payment_id, payment_amount, payment_date, loan_id) VALUES (1214, 18166, '2022-04-01', 1200112);
INSERT INTO payment (payment_id, payment_amount, payment_date, loan_id) VALUES (1215, 51861, '2022-04-15', 1200115);
INSERT INTO payment (payment_id, payment_amount, payment_date, loan_id) VALUES (1216, 162999, '2022-04-22', 1200119);
INSERT INTO payment (payment_id, payment_amount, payment_date, loan_id) VALUES (1217, 80019, '2022-04-30', 1200120);
INSERT INTO payment (payment_id, payment_amount, payment_date, loan_id) VALUES (1218, 26834, '2022-04-23', 1200124);
INSERT INTO payment (payment_id, payment_amount, payment_date, loan_id) VALUES (1219, 35754, '2022-04-07', 1200126);


INSERT INTO credit_card (credit_card_number,credit_limit,customer_id) VALUES ('3714496353984371', 30000, 101);
INSERT INTO credit_card (credit_card_number,credit_limit,customer_id) VALUES ('3643893643893654', 20000, 103);
INSERT INTO credit_card (credit_card_number,credit_limit,customer_id) VALUES ('6011016011016011', 10000, 104);
INSERT INTO credit_card (credit_card_number,credit_limit,customer_id) VALUES ('3611036110361276', 35000, 106);
INSERT INTO credit_card (credit_card_number,credit_limit,customer_id) VALUES ('3611064749361281', 20000, 108);
INSERT INTO credit_card (credit_card_number,credit_limit,customer_id) VALUES ('4562036780362678', 20000, 110);



INSERT INTO borrower(customer_id, loan_id) VALUES (101,1200102);
INSERT INTO borrower(customer_id, loan_id) VALUES (102,1200106);
INSERT INTO borrower(customer_id, loan_id) VALUES (103,1200108);
INSERT INTO borrower(customer_id, loan_id) VALUES (104,1200109);
INSERT INTO borrower(customer_id, loan_id) VALUES (105,1200112);
INSERT INTO borrower(customer_id, loan_id) VALUES (106,1200115);
INSERT INTO borrower(customer_id, loan_id) VALUES (107,1200119);
INSERT INTO borrower(customer_id, loan_id) VALUES (108,1200120);
INSERT INTO borrower(customer_id, loan_id) VALUES (109,1200124);
INSERT INTO borrower(customer_id, loan_id) VALUES (110,1200126);


INSERT INTO depositor (customer_id,account_id,access_date) VALUES (101,3982276530,'2022-03-03');
INSERT INTO depositor (customer_id,account_id,access_date) VALUES (102,8902345125,'2022-02-17');
INSERT INTO depositor (customer_id,account_id,access_date) VALUES (103,9871702287,'2022-03-13');
INSERT INTO depositor (customer_id,account_id,access_date) VALUES (104,4345010261,'2022-02-02');
INSERT INTO depositor (customer_id,account_id,access_date) VALUES (105,9124003568,'2022-03-11');
INSERT INTO depositor (customer_id,account_id,access_date) VALUES (106,5189201392,'2022-01-30');
INSERT INTO depositor (customer_id,account_id,access_date) VALUES (107,8001939743,'2022-03-03');
INSERT INTO depositor (customer_id,account_id,access_date) VALUES (108,6829743045,'2022-02-27');
INSERT INTO depositor (customer_id,account_id,access_date) VALUES (109,8028492955,'2022-03-12');
INSERT INTO depositor (customer_id,account_id,access_date) VALUES (110,8027649295,'2022-03-12');
INSERT INTO depositor (customer_id,account_id,access_date) VALUES (105,8175492955,current_date);
INSERT INTO depositor (customer_id,account_id,access_date) VALUES (106,8028406355,current_date);

INSERT INTO customer_banker(employee_id,customer_id) VALUES(1101,101);
INSERT INTO customer_banker(employee_id,customer_id) VALUES(1102,102);
INSERT INTO customer_banker(employee_id,customer_id) VALUES(1103,104);
INSERT INTO customer_banker(employee_id,customer_id) VALUES(1104,105);
INSERT INTO customer_banker(employee_id,customer_id) VALUES(1105,109);

--PROCEDURE TO DEPOSIT AMOUNT
CREATE OR REPLACE PROCEDURE deposit(amount numeric(10,2),acc_id bigint)
AS $$
BEGIN
	UPDATE account SET balance=balance+amount where account_id=acc_id;
	INSERT INTO transactions(account_id,amount,trans_type,remaining_balance)
	VALUES(acc_id, amount, 'Deposit',(select balance from account where account_id=acc_id));
	UPDATE depositor SET access_date=current_date where account_id=acc_id;
END;
$$ 
LANGUAGE plpgsql;

--PROCEDURE TO WITHDRAW AMOUNT
CREATE OR REPLACE PROCEDURE Withdrawal(amount numeric(10,2),acc_id bigint)
AS $$
BEGIN
	IF ((SELECT balance FROM account where account_id=acc_id) < amount) 
	THEN
		RAISE NOTICE 'IN SUFFICIENT BALANCE IN ACCOUNT';
	ELSE
		UPDATE account SET balance=balance-amount where account_id=acc_id;
		INSERT INTO transactions(account_id,amount,trans_type,remaining_balance)
		VALUES(acc_id, amount, 'Withdrawal',(select balance from account where account_id=acc_id));
		UPDATE depositor SET access_date=current_date where account_id=acc_id;
	END IF;
END;
$$ 
LANGUAGE plpgsql;

--PROCEDURE FOR AMOUNT TRANSFER BETWEEN TWO ACCOUNTS
CREATE OR REPLACE PROCEDURE transfer(sender bigint, receiver bigint, amount NUMERIC )
AS $$
BEGIN 
    IF ((SELECT balance FROM account WHERE account_id=sender ) < amount)
	THEN
		RAISE NOTICE 'INSUFFICIENT BALANCE IN SENDERS ACCOUNT';
    ELSE
    	UPDATE account SET balance=balance-amount WHERE account_id=sender;
		INSERT INTO transactions(account_id,amount,trans_type,remaining_balance) VALUES(sender, amount, 'Amt_sent',(select balance from account where account_id=sender));
    	UPDATE account SET balance=balance+amount WHERE account_id=receiver;
		INSERT INTO transactions(account_id,amount,trans_type,remaining_balance) VALUES(receiver, amount, 'Amt_received',(select balance from account where account_id=receiver));
		UPDATE depositor SET access_date=current_date where account_id=sender;
    END IF;
END;
$$ 
LANGUAGE plpgsql;

--PROCEDURE FOR CREATING AN ACCOUNT IN THE BANK for new customer
CREATE OR REPLACE PROCEDURE create_new_account(f_name varchar(30),l_name varchar(30),b_date date,s_name varchar(20),c_name varchar(20),em_id varchar(30),ac_type varchar(20))
AS
$$
BEGIN
	INSERT INTO customer(customer_id,first_name,last_name,birth_date,street_name,city_name,state_name,email_id)
	VALUES ((SELECT MAX(customer_id) from customer)+1,f_name,l_name,b_date,s_name,c_name,'Telangana',em_id);
	INSERT INTO account(account_id,account_type,branch_code)
	VALUES (((select MAX(account_id) from account)+round(random()*9+1)),ac_type,(SELECT branch_code FROM branch WHERE branch_city=c_name));
	INSERT INTO depositor(customer_id,account_id,access_date) 
	VALUES ((SELECT max(customer_id) FROM customer),(select max(account_id) from account),current_date);
	IF(ac_type != 'Zero Balance Account')
	THEN	
		INSERT INTO transactions(account_id,amount,trans_type,remaining_balance)
		VALUES((select max(account_id) from account), (select balance from account where account_id=(select max(account_id) from account)), 'Deposit',(select balance from account where account_id=(select max(account_id) from account)));
	END IF;
END;
$$
LANGUAGE plpgsql;

--CREATE ANOTHER ACCOUNT FOR EXISTING CUSTOMER
CREATE OR REPLACE PROCEDURE create_another_account(c_id int,a_type VARCHAR(25))
AS
$$
BEGIN
	IF (a_type = ANY(SELECT account.account_type FROM customer,depositor,account where customer.customer_id=c_id and customer.customer_id=depositor.customer_id and depositor.account_id=account.account_id))
	THEN 
		RAISE NOTICE 'ACCOUNT TYPE ALREADY EXIST SO TRY ANOTHER ACCOUNT TYPE';
	ELSE 
		INSERT INTO account(account_id,account_type,branch_code)
		VALUES (((select MAX(account_id) from account)+round(random()*9+1)),a_type,(SELECT branch_code FROM branch WHERE branch_city=(select city_name from customer where customer_id=c_id)));
		INSERT INTO depositor(customer_id,account_id,access_date) 
		VALUES ((SELECT customer_id FROM customer where customer_id=c_id),(select max(account_id) from account),current_date);
		IF(a_type != 'Zero Balance Account')
		THEN	
			INSERT INTO transactions(account_id,amount,trans_type,remaining_balance)
			VALUES((select max(account_id) from account), (select balance from account where account_id=(select max(account_id) from account)), 'Deposit',(select balance from account where account_id=(select max(account_id) from account)));
		END IF;
	END IF;
END;
$$
LANGUAGE plpgsql;

--PROCEDURE FOR CREATING LOAN
CREATE OR REPLACE PROCEDURE create_loan(c_id int,l_amt numeric(10,2),l_type varchar(30),l_duration int,int_rate numeric(4,2))
AS
$$
BEGIN
	INSERT INTO loan(loan_id,loan_amount,loan_type,loan_duration_months,interest_rate,branch_code,date_of_creation)
	VALUES ((SELECT MAX(loan_id) FROM loan)+1,l_amt,l_type,l_duration,int_rate,(
			SELECT branch_code FROM branch where branch_city=(SELECT city_name FROM customer where customer_id=c_id)
			),current_date);
	INSERT INTO borrower(customer_id,loan_id) VALUES (c_id,(SELECT MAX(loan_id) FROM loan));
	INSERT INTO Payment(payment_id,payment_amount,payment_date,loan_id)
	VALUES ((select max(payment_id) from payment)+1,0,CURRENT_DATE,(select max(loan_id) from loan));
END;
$$
LANGUAGE plpgsql;

--creating account using procedure
CALL create_account('Rithuraj','Gaikwad','1998-04-14','Ramnagar','Hyderabad','rithurajgaikwad0520@gmail.com','Zero Balance Account');
CALL create_account('Sandeep','Malhotra','1992-02-28','SRT Main Road','Medak','SandyMalhotra007@gmail.com','Checking Account');
CALL create_account('Ranjit','Kumar','1996-12-02','Old town','Nizambad','ranjitkumar0212@gmail.com','Savings Account');

--TRIGGER FOR UPDATING BALANCE WITH A GIVEN ACCOUNT TYPE
CREATE OR REPLACE FUNCTION cal_bal()
RETURNS TRIGGER
AS 
$$
BEGIN
	IF ( (SELECT account_type from account where account_id=new.account_id) = 'Checking Account')
	THEN 
		UPDATE account SET balance=5000
		WHERE account_id=new.account_id;
		RETURN NEW;
	END IF;
	IF ( (SELECT account_type from account where account_id=new.account_id) = 'Savings Account')
	THEN 
		UPDATE account SET balance=3000
		WHERE account_id=new.account_id;
		RETURN NEW;
	END IF;
	IF((SELECT account_type from account where account_id=new.account_id)= 'Zero Balance Account')
	THEN
		UPDATE account SET balance=0
		WHERE account_id=new.account_id;
		RETURN NEW;
	END IF;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER bal_cal
AFTER INSERT
ON account
FOR EACH ROW
EXECUTE PROCEDURE cal_bal();

--TRIGGER FOR CALCULATING MONTHLY_PAYMENT
CREATE OR REPLACE FUNCTION cal_emi()
RETURNS TRIGGER
AS 
$$
DECLARE emi int;
BEGIN
	emi=((select loan_amount from loan where loan_id=(select max(loan_id) from loan))*((select interest_rate from loan where loan_id=(select max(loan_id) from loan))/(12*100))*power(1+((select interest_rate from loan where loan_id=(select max(loan_id) from loan))/(12*100)),(select loan_duration_months from loan where loan_id=(select max(loan_id) from loan)))/(power(1+((select interest_rate from loan where loan_id=(select max(loan_id) from loan))/(12*100)),(select loan_duration_months from loan where loan_id=(select max(loan_id) from loan)))-1));
	UPDATE loan SET monthly_payment=emi WHERE loan_id=(select max(loan_id) from loan);	
	RETURN NEW;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER emi_cal
AFTER INSERT
ON loan
FOR EACH ROW
EXECUTE PROCEDURE cal_emi();

--TRIGGER TO CALCULATE THE TOTAL LOAN AMOUNT 
CREATE OR REPLACE FUNCTION cal_total_amt()
RETURNS TRIGGER
AS 
$$
DECLARE total int;
BEGIN
	total=((select monthly_payment from loan where loan_id=(select max(loan_id) from loan))*(select loan_duration_months from loan where loan_id=(select max(loan_id) from loan)));
	UPDATE loan SET total_payable_amount=total where loan_id=(select max(loan_id) from loan);
	RETURN NEW;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER total_amt_cal
AFTER INSERT
ON loan
FOR EACH ROW
EXECUTE PROCEDURE cal_total_amt();

--FUNCTION TO FIND THE BALANCE WITH GIVEN CUSTOMER_ID
CREATE OR REPLACE FUNCTION find_balance(c_id int)
RETURNS TABLE(account_id bigint,
			 account_type varchar(20),
			 balance numeric(10,2))
AS
$$
BEGIN
	RETURN QUERY
		SELECT 
			account.account_id,account.account_type,account.balance
		FROM 
			customer,depositor,account
		WHERE 
			customer.customer_id=c_id 
			AND customer.customer_id=depositor.customer_id 
		AND depositor.account_id=account.account_id;
END;
$$
LANGUAGE plpgsql;

--FUNCTION TO FIND AMOUNT OF LOAN PAID IN PERCENTAGE TILL LAST PAYMENT
CREATE OR REPLACE FUNCTION loan_paid_to_date(c_id int,out ans numeric(4,2))
AS
$$
BEGIN
	SELECT 
		ROUND((((SELECT EXTRACT(YEAR FROM age) * 12 + EXTRACT(MONTH FROM age) AS months_between
		FROM age((SELECT payment_date from payment where loan_id=(select loan_id from borrower where customer_id=c_id)), 
			 (select date_of_creation from loan where loan_id=(select loan_id from borrower where customer_id=c_id))))
			/(SELECT loan_duration_months from loan where loan_id=(select loan_id from borrower where customer_id=c_id)))*100),2)       
	INTO
		ans;
END;
$$
LANGUAGE plpgsql;

--FUNCTION TO COUNT NUMBER OF ACCOUNTS FOR A GIVEN CUSTOMER_ID
CREATE OR REPLACE FUNCTION account_count(c_id int,out ans int)
AS 
$$
BEGIN
	select 
		count(*) 
	into 
		ans 
	from 
		depositor 
	group by(customer_id) 
	having 
		customer_id=c_id;
end;
$$ 
LANGUAGE plpgsql;

--FUNCTION TO FIND THE CREDIT CARD NUMBER AND LIMIT WITH GIVEN ACCOUNT_ID
CREATE OR REPLACE FUNCTION account_to_cc(a_id bigint)
RETURNS TABLE (credit_card_number varchar(20),
			   credit_limit numeric(10,2))
AS 
$$
BEGIN
	RETURN QUERY
		SELECT 
			credit_card.credit_card_number, credit_card.credit_limit
		FROM 
			credit_card
		INNER JOIN
			customer ON
			credit_card.customer_id=customer.customer_id
		INNER JOIN 
			depositor ON
			customer.customer_id=depositor.customer_id
		INNER JOIN
			account ON
			depositor.account_id=account.account_id
		WHERE 
			account.account_id=a_id;
end;
$$ 
LANGUAGE plpgsql;

--VIEW FOR CUSTOMER_INFO
CREATE VIEW customer_info AS
SELECT CONCAT(customer.first_name,' ',customer.last_name) AS full_name,customer.birth_date,concat(customer.street_name,', ',customer.city_name,', ',customer.state_name) AS address,
	  string_agg(account.account_type,', ') AS type_of_account
FROM customer
full join depositor on customer.customer_id=depositor.customer_id
full join account on depositor.account_id=account.account_id
group by customer.customer_id;

--VIEW FOR CHECKING THE INFO ABOUT CUSTOMERS WHO TOOK LOANS
CREATE VIEW customer_loan AS
SELECT customer.customer_id,CONCAT(customer.first_name,' ',customer.last_name) AS full_name, loan.loan_id, loan.loan_amount, (select * from loan_paid_to_date(customer.customer_id)) AS per_loan_completed
FROM customer
inner join borrower on customer.customer_id=borrower.customer_id
inner join loan on borrower.loan_id=loan.loan_id;

--employees who are only employees
select employee.employee_name from employee 
except all
select  employee.employee_name from employee,customer,customer_banker 
where employee.employee_id=customer_banker.employee_id and customer_banker.customer_id=customer.customer_id;

--index
CREATE INDEX inx_customer_c_id ON customer USING HASH(customer_id);
CREATE INDEX inx_account_a_id ON account USING HASH(account_id);
CREATE INDEX inx_account_balance ON account USING Btree(account_id);
CREATE INDEX inx_credit_card_c_id ON credit_card USING HASH(customer_id);
CREATE INDEX inx_employee_e_id ON employee USING Hash(employee_id);
CREATE INDEX inx_employee_salary ON employee USING Btree(salary);
CREATE INDEX inx_loan_amount ON loan USING Btree(loan_amount);
CREATE INDEX inx_loan_l_id ON loan USING Hash(loan_id);

--additional index
CREATE INDEX c_inx_employee ON employee(salary) include(employee_role);
--eg: select * from employee where employee_role='Manager' and salary>50000;
CREATE INDEX c_inx_loan ON loan(loan_amount) include(loan_type);
--eg:select * from loan where loan_amount>500000 and loan_type='Equipment loan';
CREATE INDEX multi_inx_loan_b ON loan USING Btree(loan_amount,branch_code);







