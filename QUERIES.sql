-- Query A:


SELECT COUNT(*) as number_of_name
FROM Condition
WHERE name ILIKE '%kidney%';

-- Query B:

SELECT ROUND(AVG(HW.salary), 0)
FROM healthcareworker HW
    JOIN Role R ON HW.rid = R.id
WHERE R.name = 'Technician';

-- Query C:

SELECT COUNT(*)
FROM Admitted A
    JOIN Hospital H ON H.ID = A.HID
WHERE H.type = 'Government';

-- Query D:

SELECT COUNT(X)
FROM (
        SELECT hwid
        FROM Works
        WHERE quit_date IS NOT NULL
        GROUP BY hwid
        HAVING COUNT(hwid) >= 1
    ) X;

-- Query: E

SELECT COUNT(DISTINCT A.PID)
FROM Admitted A
    JOIN Patient P ON A.PID = P.ID
    JOIN Hospital H ON H.ID = A.HID
WHERE H.city = P.city;

-- Query: F


SELECT COUNT(X)
FROM (
        SELECT 1
        FROM Admitted A
        GROUP BY A.pid
        HAVING COUNT(A.pid) > 3
    ) X;

-- Query: G


SELECT COUNT(*)
FROM HealthcareWorker HW1
    JOIN Role R ON HW1.RID = R.ID
    AND R.name = 'Nurse'
    AND EXISTS (
        SELECT 1
        FROM HealthcareWorker HW2
            JOIN Role R ON HW2.RID = R.ID
            AND R.name = 'Physician'
        WHERE HW2.name = HW1.name
            AND HW1.ID != HW2.ID
    );
    
-- Query: H

SELECT COUNT(*)
FROM HealthcareWorker HW
WHERE NOT EXISTS (
        SELECT 1
        FROM HasTreated
        WHERE HWID = HW.ID
    );
    
-- Query: I


SELECT C.name as "Most common condition(s)" 
FROM Condition C 
JOIN Has H ON C.ID = H.CID
GROUP BY C.name
HAVING COUNT(*) = (SELECT COUNT(*) 
    FROM Condition C 
    JOIN Has H ON C.ID = H.CID
    GROUP BY C.name
    ORDER BY COUNT(*) DESC
    LIMIT 1
    );

-- Query: J

SELECT DISTINCT C.name
FROM Condition C
    JOIN Has H ON H.CID = C.ID
    JOIN Admitted A ON A.PID = H.PID
    JOIN Works W ON W.HID = A.HID
    JOIN Hospital HO ON HO.ID = A.HID
WHERE W.quit_date = A.admitted_date AND HO.city = 'Torrington' OR HO.city = 'Cheyenne';