DROP DATABASE IF EXISTS hospital;
CREATE DATABASE hospital;
USE hospital;

CREATE TABLE room(
	room_num VARCHAR(20) NOT NULL,
    capacity INT, 
    one_night_fee DOUBLE UNIQUE,
    PRIMARY KEY (room_num)
);

CREATE TABLE physician(
	physician_id VARCHAR(20) NOT NULL, 
    physician_name VARCHAR(50), 
    certification_number VARCHAR(20), 
    expertise_field VARCHAR(100), 
    address VARCHAR(100), 
    phone_number VARCHAR(20),
    PRIMARY KEY (physician_id)
);

CREATE TABLE nurse(
	nurse_id VARCHAR(20) NOT NULL, 
    nurse_name VARCHAR(50), 
    certification_number VARCHAR(20),
    address VARCHAR(100), 
    phone_number VARCHAR(20), 
    PRIMARY KEY (nurse_id)
);

CREATE TABLE patient(
	patient_id VARCHAR(20) NOT NULL,
    patient_name VARCHAR(50), 
    address VARCHAR(100), 
    phone_number VARCHAR(20),
    physician_id VARCHAR(20),
    room_num VARCHAR(20),
    PRIMARY KEY (patient_id),
    FOREIGN KEY (physician_id) REFERENCES physician(physician_id),
    FOREIGN KEY (room_num) REFERENCES room(room_num)
);

CREATE TABLE medicine(
	med_name VARCHAR(50) NOT NULL, 
    dosage VARCHAR(20), 
    patient_id VARCHAR(20), 
    nurse_id VARCHAR(20),
    PRIMARY KEY (med_name, patient_id),
    FOREIGN KEY (patient_id) REFERENCES patient(patient_id),
    FOREIGN KEY (nurse_id) REFERENCES nurse(nurse_id)
);

CREATE TABLE instructions(
	instruction_code VARCHAR(50) NOT NULL, 
    fee DOUBLE UNIQUE, 
    inst_description VARCHAR(100), 
    order_date DATE,
    physician_id VARCHAR(20), 
    patient_id VARCHAR(20),
    PRIMARY KEY(instruction_code),
    FOREIGN KEY (physician_id) REFERENCES physician(physician_id),
    FOREIGN KEY (patient_id) REFERENCES patient(patient_id)
);

CREATE TABLE execution(
	instruction_code VARCHAR(20) NOT NULL,
    patient_id VARCHAR(20), 
    nurse_id VARCHAR(20),
    execution_date DATE, 
    exc_status VARCHAR(100), 
    PRIMARY KEY (instruction_code, nurse_id),
    FOREIGN KEY (patient_id) REFERENCES patient(patient_id),
    FOREIGN KEY (nurse_id) REFERENCES nurse(nurse_id)
);

CREATE TABLE invoice(
	invoice_id VARCHAR(20) NOT NULL,
    room_fee DOUBLE, 
    instruction_fee DOUBLE, 
    patient_id VARCHAR(20),
    PRIMARY KEY(invoice_id), 
    FOREIGN KEY (room_fee) REFERENCES room(one_night_fee),
    FOREIGN KEY (instruction_fee) REFERENCES instructions(fee),
    FOREIGN KEY (patient_id) REFERENCES patient(patient_id)
);

CREATE TABLE payment(
	payment_id VARCHAR(20),
    invoice_id VARCHAR(20), 
    amount INT, 
    pay_date DATE, 
    PRIMARY KEY(payment_id),
    FOREIGN KEY (invoice_id) REFERENCES invoice(invoice_id)
);

CREATE TABLE health_record(
	patient_id VARCHAR(20), 
    rec_date DATE, 
    disease VARCHAR(50),
    hrecord_description VARCHAR(100),
    pat_status VARCHAR(20),
    PRIMARY KEY (patient_id), 
    FOREIGN KEY (patient_id) REFERENCES patient(patient_id)
);