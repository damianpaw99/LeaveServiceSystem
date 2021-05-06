CREATE DATABASE leave_system;
#drop database leave_system;
USE leave_system;

-- tabela danych pracowników
CREATE TABLE employees(
id INT AUTO_INCREMENT PRIMARY KEY,
firstname VARCHAR(50),
surname VARCHAR(50),
date_of_birth DATE,
email VARCHAR(50),
years_of_employment INT);




-- tabela logowania pracowników
CREATE TABLE logins(
employee_id INT, FOREIGN KEY (employee_id) REFERENCES employees(id),
login VARCHAR(20) unique,
pass VARCHAR(255));



-- tabela urlopów pracowników z datami rozpoczęcia i zakończenia urlopu
CREATE TABLE leaves_table(  
id INT AUTO_INCREMENT PRIMARY KEY,
employee_id INT NOT NULL, FOREIGN KEY (employee_id) REFERENCES employees(id),
start_date DATE,
end_date DATE);

-- tabela statusów jakie mogą mieć urlopy
CREATE TABLE statuses(
id INT AUTO_INCREMENT PRIMARY KEY,
status_name VARCHAR(50));


INSERT INTO statuses(status_name) VALUES
('Złożony'), -- 1 wniosek o urlop złożony
('Zaakceptowany'), -- 2 wniosek o urlop zaakceptowany
('Odrzucony'), -- 3 wniosek o urlop odrzucony
('Do anulacji'), -- 4 złożono wniosek o anulowanie urlopu
('Anulowany'), -- 5 urlop anulowany
('Anulowanie odrzucone'), -- 6 wniosek o anulowanie urlopu odrzucony
('Wycofany'), -- 7 wniosek o urlop wycofany (przed podjęciem przez kierownictwo jakichkolwiek decyzji po złożeniu wniosku o urlop)
('Do edycji'), # 8
('Edytowany'), #9
('Edycja odrzzucona'); #10

-- tabela łączaca urlopy ze stoatusami wraz z datą zmiany statusu wniosku o urlop
CREATE TABLE leave_has_status(
leave_id INT, FOREIGN KEY (leave_id) REFERENCES leaves_table(id),
status_id INT, FOREIGN KEY (status_id) REFERENCES statuses(id),
status_date DATETIME);




-- FUNCTIONS ----------------------------------------------------------------------------------------------------------------------------------------------------------

-- funckja sprawdzająca czy login i hasło są poprawne
DELIMITER //
CREATE FUNCTION check_pass(input_login VARCHAR(20), input_pass VARCHAR(255))
RETURNS int
DETERMINISTIC
BEGIN

DECLARE pass_correct int DEFAULT 0;

SELECT l.employee_id INTO pass_correct FROM logins l WHERE l.login=input_login AND l.pass=input_pass ;

RETURN pass_correct;
END //
DELIMITER ;



-- funckja sprawdzająca ile już dni urlopu wziął pracownik
#drop function leave_taken;
DELIMITER //
CREATE FUNCTION leave_taken(input_id INT, input_year INT)
RETURNS INT
DETERMINISTIC
BEGIN

DECLARE leaves_submitted_and_imposed INT DEFAULT 0;
DECLARE leaves_cancelled INT DEFAULT 0;
DECLARE leaves_sum INT DEFAULT 0;

SELECT sum(DATEDIFF(lt.end_date, lt.start_date))+count(*) INTO leaves_submitted_and_imposed
FROM leaves_table lt
JOIN leave_has_status lhs
ON lt.id=lhs.leave_id
WHERE lt.employee_id=input_id AND (lhs.status_id=1) and year(lt.start_date)=input_year;

SELECT sum(DATEDIFF(lt.end_date, lt.start_date))+count(*) INTO leaves_cancelled
FROM leaves_table lt
JOIN leave_has_status lhs
ON lt.id=lhs.leave_id
WHERE lt.employee_id=input_id AND (lhs.status_id=5 OR lhs.status_id=3 or lhs.status_id=7) and year(lt.start_date)=input_year;

if isnull(leaves_cancelled) then
	set leaves_cancelled=0;
end if;
if isnull(leaves_submitted_and_imposed) then
	set leaves_submitted_and_imposed=0;
end if;

SET leaves_sum=leaves_submitted_and_imposed-leaves_cancelled;
if isnull(leaves_sum) then
	set leaves_sum=0;
end if;
RETURN leaves_sum;
END //
DELIMITER ;

delimiter $$
create function newest_state(l_id int)
returns int
deterministic
begin
declare s_id int default -1;
declare last_status_date datetime;
select max(status_date) into last_status_date from leave_has_status where l_id=leave_id;
select status_id into s_id from leave_has_status where l_id=leave_id and status_date=last_status_date;
return s_id;
end$$
delimiter ;
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

-- procedura dodająca urlop do systemu
DELIMITER //
CREATE PROCEDURE add_leave(IN input_employee_id INT, IN input_start DATE, IN input_end DATE)
BEGIN
declare employee_work_years int;
declare used_days int;
declare start_year int;
declare end_year int;
declare leave_days int;

set start_year=year(input_start);
set end_year=year(input_end);

if start_year!=end_year then
signal sqlstate '45000' set message_text = 'Leave between years!';
end if;

select years_of_employment into employee_work_years from employees where id=input_employee_id;
select leave_taken(input_employee_id,start_year) into used_days;
set leave_days=datediff(input_start, input_end);

if employee_work_years>=10 then
	if used_days+leave_days<=26 then
		INSERT INTO leaves_table(employee_id, start_date, end_date) values (input_employee_id, input_start, input_end);
    else
		signal sqlstate '45001' set message_text = 'Leave days in year exeeded!';
    end if;
else
	if used_days+leave_days<=20 then
		INSERT INTO leaves_table(employee_id, start_date, end_date) values (input_employee_id, input_start, input_end);
	else
		signal sqlstate '45001' set message_text = 'Leave days in year exeeded!';
    end if;
end if;

END //
DELIMITER ;

delimiter $$
create procedure changeLeaveState(in l_id int,in state int)
begin
#('submitted'), -- 1 wniosek o urlop złożony
#('accepted'), -- 2 wniosek o urlop zaakceptowany
#('rejected'), -- 3 wniosek o urlop odrzucony
#('for_cancelation'), -- 4 złożono wniosek o anulowanie urlopu
#('cancelled'), -- 5 urlop anulowany
#('cancellation_rejected'), -- 6 wniosek o anulowanie urlopu odrzucony
#('withdrawn')#, -- 7 wniosek o urlop wycofany (przed podjęciem przez kierownictwo jakichkolwiek decyzji po złożeniu wniosku o urlop)
declare newest int default newest_state(l_id);
if((newest=1 and (state=2 or state=3 or state=7)) or (newest=2 and (state=4 or state=5)) or (newest=4 and (state=5 or state=6)))
or (newest=8 and(state=9 or state=10))
then
	insert into leave_has_status(leave_id,status_id,status_date) values (l_id,state,now());
else
	signal sqlstate '45002' set message_text = 'Incorrect new status!';
end if;
end$$
delimiter ;

-- TRIGGERS -----------------------------------------------------------------------------------------------------------------------------------------------------------
DELIMITER $$
create trigger after_leave_insert
after insert
on leaves_table for each row
begin
insert into leave_has_status(leave_id,status_id,status_date) values (new.id,1,now());
end$$
DELIMITER ;

-- VIEWS --------------------------------------------------------------------------------------------------------------------------------------------------------------

-- widok wszystkich urlopów pracowników z najnowszym statusem
CREATE VIEW employees_leaves AS
SELECT e.id as 'id',lt.id as 'leaveId', e.firstname  AS 'employeeName', e.surname AS 'employeeSurname', 
lt.start_date AS 'startDate', lt.end_date AS 'endDate',
lhs.status_date AS 'statusDate',
s.status_name AS 'status'
FROM employees e
JOIN leaves_table lt ON e.id=lt.employee_id
JOIN leave_has_status lhs ON lt.id=lhs.leave_id
JOIN statuses s ON lhs.status_id=s.id
where s.id=newest_state(lt.id);


-- widok urlopów, w związku z którymi podjąć trzeba jakąś decyzję (wniosek złożony lub złożono wniosek o anulowanie urlopu)
CREATE VIEW employees_leaves_active AS
SELECT e.id as 'id',lt.id as 'leaveId', e.firstname AS 'employeeName', e.surname AS 'employeeSurname', 
lt.start_date AS 'startDate', lt.end_date AS 'endDate',
lhs.status_date AS 'statusDate',
s.status_name AS 'status'
FROM employees e
JOIN leaves_table lt ON e.id=lt.employee_id
JOIN leave_has_status lhs ON lt.id=lhs.leave_id
JOIN statuses s ON lhs.status_id=s.id
WHERE lhs.status_id='1' OR lhs.status_id='4' or lhs.status_id='8';
