-- library management system ptoject 2

--creating branch table

DROP TABLE IF EXISTS branch;
CREATE TABLE branch(
                    branch_id VARCHAR(10) PRIMARY KEY,	
					manager_id VARCHAR(10),	
					branch_address VARCHAR(55),		
					contact_no VARCHAR(10)
);

DROP TABLE IF EXISTS employees;
CREATE TABLE employees(
                       emp_id varchar(10) PRIMARY KEY,
					   emp_name varchar(25),
					   position varchar(15),
					   salary int,
					   branch_id varchar(25) --FK

);

DROP TABLE IF EXISTS books;
CREATE TABLE books(
                   isbn	VARCHAR(20) PRIMARY KEY,
				   book_title VARCHAR(75),	
				   category	VARCHAR(20),
				   rental_price FLOAT,
				   status	VARCHAR(15),
				   author	VARCHAR(35),
				   publisher VARCHAR(55)

                   );

DROP TABLE IF EXISTS members;
CREATE TABLE members(
                  member_id	VARCHAR(10) PRIMARY KEY,
				  member_name  VARCHAR(25),
				  member_address VARCHAR(75),
				  reg_date DATE
				  );

DROP TABLE IF EXISTS issued_status;
CREATE TABLE isseud_status(
                  issued_id	VARCHAR(10) PRIMARY KEY,
				  issued_member_id	VARCHAR(10), --FK
				  issued_book_name	VARCHAR(75),
				  issued_date	date,
				  issued_book_isbn	VARCHAR(25), --FK
				  issued_emp_id VARCHAR(10)      --FK
                  );

DROP TABLE IF EXISTS return_status;
CREATE TABLE return_status(
                   return_id VARCHAR(10) PRIMARY KEY,	
				   issued_id VARCHAR(10),	
				   return_book_name	VARCHAR(75),
				   return_date	date,
				   return_book_isbn VARCHAR(20)

                  );

-- FOREIGN KEY
ALTER TABLE isseud_status
ADD CONSTRAINT fk_members
FOREIGN KEY (issued_member_id)
REFERENCES members(member_id);

ALTER TABLE isseud_status
ADD CONSTRAINT fk_books
FOREIGN KEY (issued_book_isbn)
REFERENCES books(isbn);

ALTER TABLE isseud_status
ADD CONSTRAINT fk_employees
FOREIGN KEY (issued_emp_id)
REFERENCES employees(emp_id);

ALTER TABLE return_status
ADD CONSTRAINT fk_isseud_status
FOREIGN KEY (issued_id)
REFERENCES isseud_status(issued_id);

ALTER TABLE employees
ADD CONSTRAINT fk_branch
FOREIGN KEY (branch_id)
REFERENCES branch(branch_id);



















