--There are some cases when within a table you need refer to oneself:

CREATE TABLE employee
(
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    manager_id INT,
    FOREIGN KEY (manager_id) references employee (employee_id)
);

INSERT INTO employee (employee_id, first_name, last_name, manager_id)
VALUES
    (1, 'Biba', 'Bobkin', NULL),
    (2, 'Pupa', 'Lupkin', 1),
    (3, 'Kiril', 'Mentykov', 1),
    (4, 'Roma', 'Bykovski', 2),
    (5, 'Kostya', 'Bidonov', 2),
    (6, 'Ruvik', 'Kadfgg', 3),
    (7, 'Karapuz', 'Sicirski', 3);

SELECT *
FROM employee;

SELECT e.first_name || ' ' || e.last_name as empl,
       b.first_name || ' ' || b.last_name as boss
FROM employee e
LEFT JOIN employee b ON b.employee_id = e.manager_id
ORDER BY boss;




