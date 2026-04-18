SELECT * FROM books;
SELECT * FROM branch;
SELECT * FROM employees;
SELECT * FROM isseud_status;
SELECT * FROM return_status;
SELECT * FROM members;

-- Project Task 

--Task 1. Create a New Book Record -- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee',
-- 'J.B. Lippincott & Co.')"

INSERT INTO books(isbn,book_title,category,rental_price,status,author,publisher)
VALUES
('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee',
  'J.B. Lippincott & Co.');

--Task 2: Update an Existing Member's Address

UPDATE members
SET member_address = '125 main St'
WHERE member_id ='C101';

--Task 3: Delete a Record from the Issued Status Table -- Objective: Delete the record with issued_id = 'IS121' 
--from the issued_status table.

SELECT * FROM isseud_status;

DELETE FROM isseud_status
WHERE  issued_id = 'IS121' ;


--Task 4: Retrieve All Books Issued by a Specific Employee -- Objective: Select all books issued by 
--the employee with emp_id = 'E101'.

SELECT * FROM isseud_status;

SELECT issued_book_name,
       issued_emp_id
FROM isseud_status
WHERE issued_emp_id = 'E101';	

--Task 5: List Members Who Have Issued More Than One Book -- Objective: Use GROUP BY to find members
--who have issued more than one book.

SELECT * FROM isseud_status;

SELECT 
     issued_emp_id,
	 COUNT(issued_id) as total_book_issued
FROM isseud_status
GROUP BY 1
HAVING COUNT(issued_id)>1;

--CTAS (Create Table As Select)

--Task 6: Create Summary Tables: Used CTAS to generate new tables based on query results - each book and total book_issued_cnt**
CREATE TABLE book_cnts
AS
SELECT b.isbn,
       b.book_title,
       COUNT(ist.issued_id) as no_issued
FROM books as b
JOIN
isseud_status as ist
on ist.issued_book_isbn = b.isbn
GROUP BY 1,2;

SELECT * FROM
book_cnts;


--4. Data Analysis & Findings
--The following SQL queries were used to address specific questions:

--Task 7. Retrieve All Books in a Specific Category:

SELECT * FROM books;

SELECT 
      *
	  FROM books
	  where category = 'Classic';


--Task 8: Find Total Rental Income by Category:

SELECT 
      b.category,
	  SUM(b.rental_price),
	  COUNT(*)
FROM books as b
JOIN
isseud_status as ist
on ist.issued_book_isbn = b.isbn
GROUP BY 1;


--Task 9: List Members Who Registered in the Last 180 Days:

SELECT * FROM members
	  WHERE reg_date >= CURRENT_DATE - INTERVAL '180 days';


INSERT INTO members(member_id,member_name,member_address, reg_date)
VALUES('C122','sam','133 Pine St','2025-11-01'),
     ('C123','john','143 Main St','2025-12-01');


--Task 10: List Employees with Their Branch Manager's Name and their branch details:

SELECT * FROM employees;
SELECT * FROM branch;

SELECT e.*,
       b.manager_id,
	   e2.emp_name  as manager
FROM branch as b
LEFT JOIN employees as e
on b.branch_id = e.branch_id
JOIN employees as e2
ON b.manager_id = e2.emp_id;


--Task 11. Create a Table of Books with Rental Price Above a Certain Threshold 7 USD:

CREATE TABLE books_price_greater_than_seven
AS
SELECT * FROM books
WHERE rental_price > 7;

SELECT * FROM books_price_greater_than_seven;


--Task 12: Retrieve the List of Books Not Yet Returned


SELECT * FROM books;
SELECT * FROM return_status;
SELECT * FROM isseud_status;


SELECT  
      DISTINCT ist.issued_book_name
FROM isseud_status as ist
LEFT JOIN
return_status as rs
ON ist.issued_id = rs.issued_id
WHERE rs.return_id IS NULL;
