-- Query A:
-- There are 12 conditions registered with the word injury in the name. How many
-- conditions have the word kidney in the name?
-- SELECT *
-- FROM Condition;

-- SELECT COUNT(*) as number_of_name
-- FROM Condition
-- WHERE name ILIKE '%injury%';

SELECT COUNT(*) as number_of_name
FROM Condition
WHERE name ILIKE '%kidney%';

-- Query B:
-- The average salary of all registered nurses is 77265 (rounded). What is the
-- average salary of all registered technicians (rounded)?
-- SELECT * FROM healthcareworker;
-- SELECT * FROM Role; -- id(nurse) = 0, id(technician) = 2

-- SELECT ROUND(AVG(HW.salary), 0)
-- FROM healthcareworker HW
-- JOIN Role R ON HW.rid = R.id 
-- WHERE R.name = 'Nurse';

SELECT ROUND(AVG(HW.salary), 0)
FROM healthcareworker HW
JOIN Role R ON HW.rid = R.id 
WHERE R.name = 'Technician';

-- Query C:
-- There were 5510 admissions to private hospitals. How many admissions were 
-- there to government hospitals? 

SELECT COUNT(*) FROM Admitted A JOIN Hospital H
ON H.ID = A.HID WHERE H.type = 'Government';

-- Query D:
-- Three healthcare workers have quit more than once. How many healthcare 
-- workers have quit at least once? 

SELECT COUNT(X) 
FROM (SELECT hwid
FROM Works WHERE quit_date IS NOT NULL
GROUP BY hwid
HAVING COUNT(hwid) > 1) X;

-- Query: E
-- How many patients have been admitted to a hospital in the same city as they 
-- live in? 

SELECT COUNT(DISTINCT A.PID)
FROM Admitted A
JOIN Patient P ON A.PID = P.ID
JOIN Hospital H ON H.ID = A.HID
WHERE H.city = P.city

-- Query: F
-- There were 173 patients admitted to a hospital more than 2 times. How many 
-- patients were admitted more than 3 times? 

SELECT COUNT(X)
FROM
    (SELECT 1
     FROM Admitted A
     GROUP BY A.pid
     HAVING COUNT(A.pid) > 3) X;

-- Query: G
-- For 119 nurses there exist another nurse with the same name. For how many 
-- physicians does there exist another physician with the same name? 

SELECT COUNT(*)
FROM HealthcareWorker HW1
JOIN Role R ON HW1.RID = R.ID AND R.name = 'Nurse'
    AND EXISTS
        ( SELECT 1
         FROM HealthcareWorker HW2
         JOIN Role R ON HW2.RID = R.ID AND R.name = 'Nurse'
         WHERE HW2.name = HW1.name
             AND HW1.ID != HW2.ID )

-- Query: H
-- How many healthcare workers have not treated anyone? 

SELECT HW.name FROM HealthcareWorker HW
WHERE NOT EXISTS (
    SELECT 1 FROM HasTreated WHERE HWID = HW.ID
);

-- Query: I
-- What condition(s) are most common? Return the name(s) of them in a column 
-- named "Most common condition(s)" 


-- Query: J
-- Write a query that returns a duplicate-free list of condition(s) of patients that 
-- were admitted to a hospital in either Torrington or Cheyenne on the same day 
-- that a worker who treated them quit. 

SELECT DISTINCT C.name FROM Patient P
JOIN Admitted A ON A.PID = P.ID  

