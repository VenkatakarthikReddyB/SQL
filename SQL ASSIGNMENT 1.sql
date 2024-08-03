USE Selectiva;
CREATE TABLE ADDRESS (
    add_id          INT PRIMARY KEY,
    country         VARCHAR(20),
    state           VARCHAR(20),
    city            VARCHAR(30),
    street          VARCHAR(50),
    zipcode         MEDIUMINT,
    pre_known_add   JSON,
    created_ts      TIMESTAMP,
    last_updated_ts TIMESTAMP
);

CREATE TABLE DEPARTMENT (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(60),
    department_code CHAR(4) NOT NULL,
    address_id INT,
    dept_head_id INT NOT NULL,
    CONSTRAINT Add_id_Dept_FK FOREIGN KEY (address_id)
    REFERENCES ADDRESS(add_id)
);

CREATE TABLE EMP (
    emp_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(20),
    email VARCHAR(80) NOT NULL,
    phone_number VARCHAR(15) NOT NULL,
    dept_id INT,
    address_id INT,
    blood_group VARCHAR(10),
    dob DATE,
    doj DATE,
    dot DATE,
    created_ts TIMESTAMP,
    reference VARCHAR(100),
    role VARCHAR(80),
    salary FLOAT,
    band INT,
    reports_to INT,
    CONSTRAINT dept_id_FK FOREIGN KEY (dept_id) REFERENCES DEPARTMENT(department_id),
    CONSTRAINT Add_id_EMP_FK FOREIGN KEY (address_id) REFERENCES ADDRESS(add_id)
);






INSERT INTO ADDRESS (add_id, country, state, city, street, zipcode, pre_known_add, created_ts, last_updated_ts)
VALUES
(1, 'USA', 'TEXAS', 'Denton', '1408 Teasley LN', 76205, '{"landmark": "Near First United Bank"}', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 'USA', 'TEXAS', 'Dallas', '300 Renioun blvd', 75207, '{"landmark": "Near reunion Tower"}', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(3, 'USA', 'Nevada', 'Vegas', ' Teasley LN', 89119, '{"landmark": "Near First United Bank"}', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(4, 'USA', 'Nevada', 'Vegas', '300 mountain street', 89120, '{"landmark": "Near reunion Tower"}', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
 


INSERT INTO DEPARTMENT (department_id, department_name, department_code, address_id, dept_head_id)
VALUES
(1, 'HR', 'HR_1', 4, 103),
(2, 'SD', 'SD_1', 2, 101),
(3, 'DE', 'DE_1', 3, 104),
(4, 'BA', 'BA_1', 1, 102);

 
 INSERT INTO EMP (emp_id, first_name, last_name, email, phone_number, dept_id, address_id, blood_group, dob, doj, dot, created_ts, reference, role, salary, band, reports_to)
VALUES
(1, 'ram', 'S', 'ram@gmail.com', '555-555-5555',   1, 4, 'O+', '1999-01-15', '2020-02-01', NULL, CURRENT_TIMESTAMP, 'Mr.S', 'Senior HR', 100000, 2, NULL),
(2, 'sai', 'R', 'sai@gmail.com', '111-111-1111',   2, 2, 'A-', '1998-05-22', '2021-03-15', NULL, CURRENT_TIMESTAMP, 'Mr.Y', 'Junior BA', 90000, 3, 1),
(3, 'kumar','O','kumar@gmail.com', '666-555-5555', 3, 3, 'B+', '1995-01-15', '2023-02-01', NULL, CURRENT_TIMESTAMP, 'Mr.P', 'Senior DE ', 120000, 2, NULL),
(4, 'sam', 'G', 'sam@gmail.com', '777-111-1111',   4, 1, 'B-', '1997-05-22', '2023-03-15', NULL, CURRENT_TIMESTAMP, 'Mr.L', 'Analyst', 80000, 3, 3);




UPDATE EMP SET last_name="K", dob='1998-01-15' where emp_id=3;
UPDATE DEPARTMENT SET department_name='SR.HR' WHERE department_id=1;
UPDATE ADDRESS set state='Ohio' where add_id=4;



DELETE FROM EMP WHERE emp_id=3;
DELETE FROM DEPARTMENT WHERE department_id=3;
DELETE FROM ADDRESS WHERE add_id=3;



ALTER TABLE EMP
DROP COLUMN reports_to;

ALTER TABLE DEPARTMENT
DROP COLUMN dept_head_id;

ALTER TABLE EMP
MODIFY band varchar(10);

SELECT emp_id, first_name, last_name, dept_id, address_id, TIMESTAMPDIFF(YEAR, dob, CURDATE()) AS AGE FROM EMP;

SELECT curdate() AS TODAY_DATE;

SELECT emp_id, first_name, last_name, TIMESTAMPDIFF(YEAR, doJ, CURDATE()) AS 'EXPERIENCE(YEARS)' FROM EMP;



ALTER TABLE EMP ADD COLUMN comment_col VARCHAR(50);

ALTER TABLE DEPARTMENT ADD COLUMN comment_col VARCHAR(50);

ALTER TABLE ADDRESS ADD COLUMN comment_col VARCHAR(50);





create view Emp_View as 
select e.emp_id, 
    case 
		when e.last_name is not null then concat(e.first_name , ' ' , e.last_name) 
		else e.first_name 
	END AS name,
    concat(a.street, ', ', a.city, ', ', a.state, ', ', a.country, a.zipcode) as address,
    d.department_name as dept_name,
	e.salary as salary 
from emp as e 
join department as d on e.dept_id=d.department_id
join address as a on a.add_id=e.address_id;


select * from Emp_View;

drop view emp_view;



SELECT CONCAT('TRUNCATE TABLE ',table_schema,'.',TABLE_NAME, ';') 
    FROM INFORMATION_SCHEMA.TABLES WHERE table_schema IN ('Selectiva');
    
    
 /*   
TRUNCATE TABLE EMP;
TRUNCATE TABLE DEPARTMENT;
TRUNCATE TABLE ADDRESS;

*/

DROP TABLE EMP;
DROP TABLE DEPARTMENT;
DROP TABLE ADDRESS;

