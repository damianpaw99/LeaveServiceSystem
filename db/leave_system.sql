CREATE DATABASE leave_system;
USE leave_system;

CREATE TABLE employees(
id INT AUTO_INCREMENT PRIMARY KEY,
firstname VARCHAR(50),
surname VARCHAR(50),
date_of_birth DATE,
email VARCHAR(50),
years_of_employment INT);

SELECT * FROM employees;

insert into employees(firstname, surname, date_of_birth, email, years_of_employment) values 
('Jan', 'Kowalski', '1990-10-10', 'jankowal@gmail.com', '3'),
('Adam', 'Nowak', '1995-12-11', 'adamnowak@gmail.com', '2'),
('Krystyna', 'Szymanska', '1970-04-01', 'krystynaszymanska@gmail.com', '5');


CREATE TABLE logins(
employee_id INT, FOREIGN KEY (employee_id) REFERENCES employees(id),
login VARCHAR(20),
pass VARCHAR(255));

SELECT * FROM logins;

insert into logins(employee_id, login, pass) values
('1', 'jankowalski', '1234'),
('2', 'adamnowak', '12345'),
('3', 'krystynaszymanska', '123456');


CREATE TABLE leaves_table(  
id INT AUTO_INCREMENT PRIMARY KEY,
employee_id INT NOT NULL, FOREIGN KEY (employee_id) REFERENCES employees(id),
start_date DATE,
end_date DATE);

SELECT * FROM leaves_table;

insert into leaves_table(employee_id, start_date, end_date) values 
-- ('1', '2021-05-04', '2021-05-10'),
-- ('1', '2021-05-12', '2021-06-10'),
-- ('2', '2021-04-04', '2021-04-12');
('1', '2021-04-04', '2021-04-06');


CREATE TABLE statuses(
id INT AUTO_INCREMENT PRIMARY KEY,
status_name VARCHAR(50));

SELECT * FROM statuses;

INSERT INTO statuses(status_name) VALUES
('submitted'), -- 1
('accepted'), -- 2
('rejected'), -- 3
('for_cancelation'), -- 4
('cancelled'), -- 5
('cancellation_rejected'), -- 6
('withdrawn'), -- 7
('imposed'); -- 8


CREATE TABLE leave_has_status(
leave_id INT, FOREIGN KEY (leave_id) REFERENCES leaves_table(id),
status_id INT, FOREIGN KEY (status_id) REFERENCES statuses(id),
status_date DATETIME);

SELECT * FROM leave_has_status;

insert into leave_has_status(leave_id, status_id, status_date) values
 -- ('1', '2', '2021-04-27 12:50:50'),
-- ('1', '6', '2021-04-27 07:10:10'),
 -- ('2', '7', '2021-03-17 08:40:12'),
 -- ('2', '5', '2021-03-17 08:40:12');
 ('2', '4', '2021-03-17 08:40:12');


-- FUNCTIONS ----------------------------------------------------------------------------------------------------------------------------------------------------------

DELIMITER //
CREATE FUNCTION check_pass(input_login varchar(20), input_pass varchar(255))
RETURNS BOOLEAN
DETERMINISTIC
BEGIN

DECLARE pass_correct BOOLEAN DEFAULT false;

SELECT true INTO pass_correct from logins l where l.login=input_login and l.pass=input_pass ;

RETURN pass_correct;
END //
DELIMITER ;

select check_pass('adamnowak', '123455');

DELIMITER //
CREATE FUNCTION leave_taken(input_id int, input_year int)
RETURNS INT
DETERMINISTIC
BEGIN

DECLARE leaves_sumbitted_and_imposed INT DEFAULT 0;
DECLARE leaves_cancelled INT DEFAULT 0;
DECLARE leaves_sum INT DEFAULT 0;

SELECT sum(DATEDIFF(end_date, start_date)) INTO leaves_sumbitted_and_imposed
FROM leaves_table lt
JOIN leave_has_status lhs
ON lt.id=lhs.leave_id
WHERE lt.employee_id=input_id AND (lhs.status_id=2 OR lhs.status_id=8);

SELECT sum(DATEDIFF(end_date, start_date)+1) INTO leaves_cancelled
FROM leaves_table lt
JOIN leave_has_status lhs
ON lt.id=lhs.leave_id
WHERE lt.employee_id=input_id AND lhs.status_id=5;

SELECT leaves_sumbitted_and_imposed-leaves_cancelled INTO leaves_sum;

RETURN leaves_sum;
END //
DELIMITER ;

select leave_taken('1', '2021');

-- PROCEDURES ---------------------------------------------------------------------------------------------------------------------------------------------------------


-- VIEWS --------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE VIEW employees_leaves AS
SELECT e.firstname AS 'Employee name', e.surname AS 'Employee surname', 
lt.start_date AS 'First date of leave', lt.end_date AS 'Last date of leave',
lhs.status_date AS 'Date of status change',
s.status_name AS 'Status'
FROM employees e
JOIN leaves_table lt ON e.id=lt.employee_id
JOIN leave_has_status lhs ON lt.id=lhs.leave_id
JOIN statuses s ON lhs.status_id=s.id;

select * from employees_leaves;

CREATE VIEW employees_leaves_active AS
SELECT e.firstname AS 'Employee name', e.surname AS 'Employee surname', 
lt.start_date AS 'First date of leave', lt.end_date AS 'Last date of leave',
lhs.status_date AS 'Date of status change',
s.status_name AS 'Status'
FROM employees e
JOIN leaves_table lt ON e.id=lt.employee_id
JOIN leave_has_status lhs ON lt.id=lhs.leave_id
JOIN statuses s ON lhs.status_id=s.id
WHERE lhs.status_id='1' OR lhs.status_id='4';

select * from employees_leaves_active;