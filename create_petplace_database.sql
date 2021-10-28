DROP DATABASE IF EXISTS petsPlace;
CREATE DATABASE petsPlace;

-- select the database
-- USE petsPlace;

CREATE TABLE petsPlace.`pets` (
  `pets_id` INT NOT NULL AUTO_INCREMENT,
  `owner_id` INT NOT NULL,
  `pet_name` VARCHAR(30) NOT NULL,
  `pet_breed` VARCHAR(45) NOT NULL,
  `pet_allergies` VARCHAR(45) NOT NULL,
  `pet_weight` VARCHAR(10) NOT NULL,
  `pet_age_years` INT NOT NULL,
  `pet_behavior` VARCHAR(45) NOT NULL,
  `visit_id` INT NOT NULL,
  `store_id` INT NOT NULL,
--    CONSTRAINT pet_customer_relationship
--     FOREIGN KEY (owner_id)
--     REFERENCES customer_pet_owner (owner_id),
  PRIMARY KEY (`pets_id`)
);

CREATE TABLE petsPlace.`customer_pet_owner` (
  `owner_id` INT NOT NULL AUTO_INCREMENT,
  `pets_id` INT NOT NULL,
  `cust_fname` VARCHAR(45) NOT NULL,
  `cust_lname` VARCHAR(45) NOT NULL,
  `cust_address` VARCHAR(45) NOT NULL,
  `cust_city` VARCHAR(45) NOT NULL,
  `cust_state` VARCHAR(45) NOT NULL,
  `cust_zip` INT NOT NULL,
  `cust_phone` VARCHAR(15) NOT NULL,
--    CONSTRAINT customer_pet_relationship
--     FOREIGN KEY (pets_id)
--     REFERENCES pets (pets_id),
  PRIMARY KEY (`owner_id`));

CREATE TABLE petsPlace.`store_location` (
  `store_id` INT NOT NULL AUTO_INCREMENT,
  `store_name` VARCHAR(45) NOT NULL,
  `store_address` VARCHAR(45) NOT NULL,
  `store_state` VARCHAR(45) NOT NULL,
  `store_city` VARCHAR(45) NOT NULL,
  `store_zip` VARCHAR(45) NOT NULL,
  `store_phone` VARCHAR(45) NOT NULL,
  `emp_id` INT NOT NULL,
  `dept_id` INT NOT NULL,
--    CONSTRAINT store_employees
--     FOREIGN KEY (emp_id)
--     REFERENCES employee (emp_id),
--    CONSTRAINT store_departments
--     FOREIGN KEY (dept_id)
--     REFERENCES department (dept_id), 
  PRIMARY KEY (`store_id`));

CREATE TABLE petsPlace.`department` (
  `dept_id` INT NOT NULL AUTO_INCREMENT,
  `dept_name` VARCHAR(45) NOT NULL,
  `dept_phone` VARCHAR(15) NOT NULL,
  `store_id` INT NOT NULL,
  `dept_email` VARCHAR(45) NOT NULL,
--    CONSTRAINT department_store
--     FOREIGN KEY (store_id)
--     REFERENCES store_location (store_id),
  PRIMARY KEY (`dept_id`));

CREATE TABLE petsPlace.`employee` (
  `emp_id` INT NOT NULL AUTO_INCREMENT,
  `emp_fname` VARCHAR(45) NOT NULL,
  `emp_lname` VARCHAR(45) NOT NULL,
  `emp_phone` VARCHAR(15) NOT NULL,
  `store_id` INT NOT NULL,
--    CONSTRAINT employee_assigned_store
--     FOREIGN KEY (store_id)
--     REFERENCES store_location (store_id),
  PRIMARY KEY (`emp_id`));

CREATE TABLE petsPlace.`previous_visit` (
  `visit_id` INT NOT NULL AUTO_INCREMENT,
  `service_id` INT NOT NULL,
  `visit_date` DATE NOT NULL,
  `visit_duration` VARCHAR(10) NOT NULL,
  `emp_id` INT NOT NULL,
--    CONSTRAINT service_during_visit
--     FOREIGN KEY (service_id)
--     REFERENCES service (service_id),
--    CONSTRAINT employee_at_visit
--     FOREIGN KEY (emp_id)
--     REFERENCES employee (emp_id), 
  PRIMARY KEY (`visit_id`));

CREATE TABLE petsPlace.`service` (
  `service_id` INT NOT NULL AUTO_INCREMENT,
  `service_type` VARCHAR(45) NOT NULL,
  `service_description` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`service_id`));
  
ALTER TABLE petsPlace.pets ADD (
    CONSTRAINT pet_customer_relationship
	 FOREIGN KEY (owner_id)
	 REFERENCES customer_pet_owner (owner_id),
	CONSTRAINT pet_last_visit
     FOREIGN KEY (visit_id)
     REFERENCES previous_visit (visit_id),
	CONSTRAINT pet_assigned_store
     FOREIGN KEY (store_id)
     REFERENCES store_location (store_id)); 

ALTER TABLE petsPlace.customer_pet_owner ADD (
	CONSTRAINT customer_pet_relationship
     FOREIGN KEY (pets_id)
     REFERENCES pets (pets_id));

ALTER TABLE petsPlace.store_location ADD (
   CONSTRAINT store_employees
    FOREIGN KEY (emp_id)
    REFERENCES employee (emp_id),
   CONSTRAINT store_departments
    FOREIGN KEY (dept_id)
    REFERENCES department (dept_id));

ALTER TABLE petsPlace.department ADD (
   CONSTRAINT department_store
    FOREIGN KEY (store_id)
    REFERENCES store_location (store_id));

ALTER TABLE petsPlace.employee ADD (
   CONSTRAINT employee_assigned_store
    FOREIGN KEY (store_id)
    REFERENCES store_location (store_id));

ALTER TABLE petsPlace.previous_visit ADD (
   CONSTRAINT service_during_visit
    FOREIGN KEY (service_id)
    REFERENCES service (service_id),
   CONSTRAINT employee_at_visit
    FOREIGN KEY (emp_id)
    REFERENCES employee (emp_id));
