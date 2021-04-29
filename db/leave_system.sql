CREATE DATABASE leave_system;
USE leave_system;

-- tabela danych pracowników
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

-- tabela logowania pracowników
CREATE TABLE logins(
employee_id INT, FOREIGN KEY (employee_id) REFERENCES employees(id),
login VARCHAR(20),
pass VARCHAR(255));

SELECT * FROM logins;

insert into logins(employee_id, login, pass) values
('1', 'jankowalski', '1234'),
('2', 'adamnowak', '12345'),
('3', 'krystynaszymanska', '123456');

-- tabela urlopów pracowników z datami rozpoczęcia i zakończenia urlopu
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

-- tabela statusów jakie mogą mieć urlopy
CREATE TABLE statuses(
id INT AUTO_INCREMENT PRIMARY KEY,
status_name VARCHAR(50));

SELECT * FROM statuses;

INSERT INTO statuses(status_name) VALUES
('submitted'), -- 1 wniosek o urlop złożony
('accepted'), -- 2 wniosek o urlop zaakceptowany
('rejected'), -- 3 wniosek o urlop odrzucony
('for_cancelation'), -- 4 złożono wniosek o anulowanie urlopu
('cancelled'), -- 5 urlop anulowany
('cancellation_rejected'), -- 6 wniosek o anulowanie urlopu odrzucony
('withdrawn'), -- 7 wniosek o urlop wycofany (przed podjęciem przez kierownictwo jakichkolwiek decyzji po złożeniu wniosku o urlop)
('imposed'); -- 8 urlop narzucony z góry

-- tabela łączaca urlopy ze stoatusami wraz z datą zmiany statusu wniosku o urlop
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

-- funckja sprawdzająca czy login i hasło są poprawne
DELIMITER //
CREATE FUNCTION check_pass(input_login VARCHAR(20), input_pass VARCHAR(255))
RETURNS BOOLEAN
DETERMINISTIC
BEGIN

DECLARE pass_correct BOOLEAN DEFAULT false;

SELECT true INTO pass_correct FROM logins l WHERE l.login=input_login AND l.pass=input_pass ;

RETURN pass_correct;
END //
DELIMITER ;

select check_pass('adamnowak', '123455');

-- funckja sprawdzająca ile już dni urlopu wziął pracownik
DELIMITER //
CREATE FUNCTION leave_taken(input_id INT, input_year INT)
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

-- procedura dodająca pracownika do systemu
DELIMITER //
CREATE PROCEDURE add_employee(IN input_name VARCHAR(50), IN input_surname VARCHAR(50), IN input_birth DATE, IN input_email VARCHAR(50), IN input_years_employment INT, 
IN input_log VARCHAR(20), IN input_pass VARCHAR(255))
BEGIN

DECLARE new_employee_id INT;
INSERT INTO employees(firstname, surname, date_of_birth, email, years_of_employment) values (input_name, input_surname, input_birth, input_email, input_years_employment);
SELECT id e INTO new_employee_id FROM employees e ORDER BY id desc limit 1; 
INSERT INTO logins(employee_id, login, pass) VALUES (new_employee_id, input_log, input_pass);
END //
DELIMITER ;

call add_employee('Anna', 'Nowicka', '1990-10-10', 'annanow@gmail.com', '1', 'annanowicka', '123');

-- procedura dodająca urlop do systemu
DELIMITER //
CREATE PROCEDURE add_leave(IN input_employee_id INT, IN input_start DATE, IN input_end DATE)
BEGIN

DECLARE new_leave_id INT;
INSERT INTO leaves_table(employee_id, start_date, end_date) values (input_employee_id, input_start, input_end);
SELECT id lt INTO new_leave_id FROM leaves_table lt ORDER BY id desc limit 1; 
INSERT INTO leave_has_status(leave_id, status_id, status_date) VALUES (new_leave_id, '1', CURRENT_TIMESTAMP );
END //
DELIMITER ;

call add_leave('2', '2021-06-01', '2021-06-05');

-- VIEWS --------------------------------------------------------------------------------------------------------------------------------------------------------------

-- widok wszystkich urlopów pracowników
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

-- widok urlopów, w związku z którymi podjąć trzeba jakąś decyzję (wniosek złożony lub złożono wniosek o anulowanie urlopu)
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