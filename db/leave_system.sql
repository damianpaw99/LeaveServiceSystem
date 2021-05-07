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
('Do edycji'), -- 8 złożono wniosek o edytowanie dat urlopu
('Edytowany'), -- 9 wniosek o edytowanie urlopu zaakceptowany
('Edycja odrzucona'); -- 10 wniosek o edytowanie urlopu odrzucony

-- tabela łączaca urlopy ze statusami wraz z datą zmiany statusu wniosku o urlop
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
DELIMITER //
CREATE FUNCTION leave_taken(input_id INT, input_year INT)
RETURNS INT
DETERMINISTIC
BEGIN

DECLARE leaves_submitted INT;
DECLARE leaves_cancelled INT DEFAULT 0;
DECLARE leaves_sum INT DEFAULT 0;

SELECT sum(days_between(lt.start_date, lt.end_date)) INTO leaves_submitted
FROM leaves_table lt
JOIN leave_has_status lhs
ON lt.id=lhs.leave_id
WHERE lt.employee_id=input_id AND (lhs.status_id=1) and year(lt.start_date)=input_year;

SELECT sum(days_between(lt.start_date, lt.end_date)) INTO leaves_cancelled
FROM leaves_table lt
JOIN leave_has_status lhs
ON lt.id=lhs.leave_id
WHERE lt.employee_id=input_id AND (lhs.status_id=5 OR lhs.status_id=3 OR lhs.status_id=7) AND YEAR(lt.start_date)=input_year;

IF isnull(leaves_cancelled) THEN
	SET leaves_cancelled=0;
END IF;
IF isnull(leaves_submitted) THEN
	SET leaves_submitted=0;
END IF;

SET leaves_sum=leaves_submitted-leaves_cancelled;
IF isnull(leaves_sum) THEN
	SET leaves_sum=0;
END IF;
RETURN leaves_sum;
END //
DELIMITER ;

-- funckja sprawdzająca jaki jest najnowszy status urlopu
DELIMITER //
CREATE FUNCTION newest_state(l_id INT)
RETURNS INT
DETERMINISTIC
BEGIN
DECLARE s_id INT DEFAULT -1;
DECLARE last_status_date DATETIME;
SELECT max(status_date) INTO last_status_date FROM leave_has_status WHERE l_id=leave_id LIMIT 1;
SELECT status_id INTO s_id FROM leave_has_status WHERE l_id=leave_id AND status_date=last_status_date LIMIT 1;
RETURN s_id;
END$$
DELIMITER ;

-- funkcja sprawdzająca ilość dni roboczych pomiędzy dwoma datami
DELIMITER //
CREATE FUNCTION days_between(date1 DATE, date2 DATE)
RETURN INT
DETERMINISTIC
BEGIN
DECLARE count INT DEFAULT 0;
DECLARE tempdate DATE DEFAULT date1;

WHILE datediff(date2,tempdate)!=-1 DO
IF(dayofweek(tempdate)=1 OR dayofweek(tempdate)=7) THEN
SET count=count+1;
END IF;
SET tempdate=adddate(tempdate, INTERVAL 1 DAY);
END WHILE;
RETURN datediff(date2,date1)-count+1;
END$$
DELIMITER ;

-- funkcja sprawdzająca ile dni urlopu pozostało praocwnikowi do pobrania w danym roku 
DELIMITER //
CREATE FUNCTION days_left(employee_id INT, input_year INT)
RETURN INT
DETERMINISTIC
BEGIN
DECLARE test INT;
SELECT years_of_employment INTO test FROM employees WHERE id=employee_id;
IF(test<10) THEN
RETURN 20-leave_taken(employee_id, input_year);
ELSE
RETURN 26-leave_taken(employee_id, input_year);
END IF;
END$$
DELIMITER ;


-- PROCEDURES ---------------------------------------------------------------------------------------------------------------------------------------------------------

-- procedura dodająca pracownika do systemu
DELIMITER //
CREATE PROCEDURE add_employee(IN input_name VARCHAR(50), IN input_surname VARCHAR(50), IN input_birth DATE, IN input_email VARCHAR(50), IN input_years_employment INT, 
IN input_log VARCHAR(20), IN input_pass VARCHAR(255)) 
BEGIN
DECLARE check_login BOOLEAN DEFAULT FALSE;
DECLARE new_employee_id INT;
SELECT TRUE INTO check_login FROM logins WHERE login=input_log;
IF check_login = TRUE THEN
	SIGNAL SQLSTATE '45002' SET MESSAGE_TEXT='Login is already in database';
ELSE
	INSERT INTO employees(firstname, surname, date_of_birth, email, years_of_employment) VALUES (input_name, input_surname, input_birth, input_email, input_years_employment);
	SELECT id e INTO new_employee_id FROM employees e ORDER BY id desc limit 1; 
	INSERT INTO logins(employee_id, login, pass) VALUES (new_employee_id, input_log, input_pass);
END IF;
END //
DELIMITER ;

-- procedura dodająca urlop do systemu
DELIMITER //
CREATE PROCEDURE add_leave(IN input_employee_id INT, IN input_start DATE, IN input_end DATE)
BEGIN
DECLARE employee_work_years INT;
DECLARE used_days INT;
DECLARE start_year INT;
DECLARE end_year INT;
DECLARE leave_days INT;

SET start_year = YEAR(input_start);
SET end_year = YEAR(input_end);

IF start_year!=end_year THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Leave between years!';
END IF;

SELECT years_of_employment INTO employee_work_years FROM employees WHERE id=input_employee_id;
SELECT leave_taken(input_employee_id,start_year) INTO used_days;
SET leave_days=datediff(input_end, input_start);

IF employee_work_years>=10 THEN
	IF used_days+leave_days<=26 THEN
		INSERT INTO leaves_table(employee_id, start_date, end_date) VALUES (input_employee_id, input_start, input_end);
    ELSE
		SIGNAL SQLSTATE '45001' SET MESSAGE_TEXT = 'Leave days in year exeeded!';
    END IF;
ELSE
	IF used_days+leave_days<=20 THEN
		INSERT INTO leaves_table(employee_id, start_date, end_date) VALUES (input_employee_id, input_start, input_end);
	ELSE
		SIGNAL SQLSTATE '45001' SET MESSAGE_TEXT = 'Leave days in year exeeded!';
    END IF;
END IF;

END //
DELIMITER ;

-- procedura zmieniająca aktualny status urlopu
DELIMITER //
CREATE PROCEDURE changeLeaveState(IN l_id INT, IN state INT)
BEGIN

DECLARE newest INT DEFAULT newest_state(l_id);
IF((newest=1 AND (state=2 OR state=3 OR state=7)) OR (newest=2 AND (state=4 OR state=5 OR state=8)) OR (newest=4 AND (state=5 OR state=6)))
OR (newest=8 AND(state=9 OR state=10))
THEN
	INSERT INTO leave_has_status(leave_id,status_id,status_date) VALUES (l_id,state,now());
ELSE
	SIGNAL SQLSTATE '45002' SET MESSAGE_TEXT = 'Incorrect new status!';
END IF;
END$$
DELIMITER ;


-- TRIGGERS -----------------------------------------------------------------------------------------------------------------------------------------------------------

-- trigger dodający do tablicy łączącej urlopy ze statusami nowy rekord i datę zmiany statusu po dodaniu urlopu do tabeli urlopów
DELIMITER //
CREATE TRIGGER after_leave_insert
AFTER INSERT
ON leaves_table FOR EACH ROW
BEGIN
INSERT INTO leave_has_status(leave_id,status_id,status_date) VALUES (NEW.id,1,now());
END$$
DELIMITER ;


-- VIEWS --------------------------------------------------------------------------------------------------------------------------------------------------------------

-- widok wszystkich urlopów pracowników z najnowszym statusem
CREATE VIEW employees_leaves AS
SELECT e.id AS 'id', lt.id AS 'leaveId', e.firstname  AS 'employeeName', e.surname AS 'employeeSurname', 
lt.start_date AS 'startDate', lt.end_date AS 'endDate',
lhs.status_date AS 'statusDate',
s.status_name AS 'status'
FROM employees e
JOIN leaves_table lt ON e.id=lt.employee_id
JOIN leave_has_status lhs ON lt.id=lhs.leave_id
JOIN statuses s ON lhs.status_id=s.id
WHERE s.id=newest_state(lt.id);

-- widok urlopów, w związku z którymi podjąć trzeba jakąś decyzję (wniosek złożony lub złożono wniosek o anulowanie urlopu)
CREATE VIEW employees_leaves_active AS
SELECT e.id AS 'id', lt.id AS 'leaveId', e.firstname AS 'employeeName', e.surname AS 'employeeSurname', 
lt.start_date AS 'startDate', lt.end_date AS 'endDate',
lhs.status_date AS 'statusDate',
s.status_name AS 'status'
FROM employees e
JOIN leaves_table lt ON e.id=lt.employee_id
JOIN leave_has_status lhs ON lt.id=lhs.leave_id
JOIN statuses s ON lhs.status_id=s.id
WHERE (lhs.status_id='1' OR lhs.status_id='4' OR lhs.status_id='8') AND s.id=newest_state(lt.id);

-- widok wszystkich pracowników posiadających konto w systemie obsługi usloprów (dla kierownictwa)
CREATE VIEW all_employees AS
SELECT id AS 'id',
firstname AS 'name',
surname AS 'surname',
date_of_birth AS 'birthDate',
email AS 'email',
years_of_employment AS 'employmentYears'
FROM employees;


-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- tworzenie userów i nadawanie im uprawnień:

create user 'employee'@'localhost' identified by 'employeePass' ;
grant execute on procedure changeLeaveState to 'employee'@'localhost';
grant select on employees_leaves to 'employee'@'localhost';
grant execute on procedure add_leave to 'employee'@'localhost';
grant execute on function days_left to 'employee'@'localhost';

create user 'manager'@'localhost' identified by 'managerPassword';
grant execute on procedure changeLeaveState to 'manager'@'localhost';
grant select on all_employees to 'manager'@'localhost';
grant select on employees_leaves to 'manager'@'localhost';
grant select on employees_leaves_active to 'manager'@'localhost';

create user 'logger'@'localhost' identified by 'loggerPass';
grant execute on function check_pass to 'logger'@'localhost';

create user 'create'@'localhost' identified by 'createPass';
grant execute on procedure add_employee to 'create'@'localhost';