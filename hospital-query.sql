#SQL Queries
SELECT patient_name, room_num 
FROM patient JOIN physician ON patient.physician_id = physician.physician_id 
WHERE physician_name = 'Justin Zhang';

SELECT patient_name, room_num
FROM patient WHERE room_num IN (SELECT room_num FROM room WHERE one_night_fee > 5000);

SELECT AVG(one_night_fee) as 'Fee Average' FROM room
WHERE capacity > 15;

SELECT nurse_name FROM nurse 
WHERE nurse_id IN (SELECT nurse_id FROM medicine WHERE med_name = 'Warfarin');

SELECT physician_name, SUM(fee) 
FROM instructions JOIN physician ON instructions.physician_id = physician.physician_id
GROUP BY physician_name;

SELECT patient_name, nurse_name, med_name 
FROM patient JOIN medicine ON patient.patient_id = medicine.patient_id
JOIN nurse ON medicine.nurse_id = nurse.nurse_id;

SELECT nurse_name FROM nurse
WHERE nurse_id IN (SELECT nurse_id FROM execution WHERE exc_status = 'COMPLETE');

SELECT physician_name FROM physician
WHERE physician_id IN (SELECT physician_id FROM instructions WHERE order_date >= '2022-11-05');

SELECT instructions.instruction_code, physician_id, execution.exc_status 
FROM instructions JOIN execution ON instructions.instruction_code = execution.instruction_code;

SELECT patient_name, room_num FROM patient 
WHERE patient_id IN (SELECT patient_id FROM health_record WHERE pat_status = 'BEING TREATED');

SELECT * FROM patient WHERE patient_name LIKE '%Watts';

SELECT expertise_field FROM physician WHERE physician_id = '8PWPJ839VTYV';

SELECT physician_name, certification_number FROM physician WHERE expertise_field = 'Pediatrics';

SELECT nurse_name FROM nurse INNER JOIN execution ON nurse.nurse_id = execution.nurse_id WHERE patient_id = 'Z50GCO4R';

SELECT DISTINCT(invoice.patient_id)
FROM invoice JOIN payment ON invoice.invoice_id = payment.invoice_id 
WHERE payment.pay_date >= '2022-11-10';

SELECT patient_name, rec_date, disease FROM health_record, patient WHERE health_record.patient_id = patient.patient_id;
 
SELECT order_date, instruction_code, inst_description FROM instructions WHERE order_date BETWEEN "2022-01-01" AND "2022-12-31";

#SQL Triggers
DELIMITER //
CREATE TRIGGER nurse_required
BEFORE INSERT ON medicine FOR EACH ROW
BEGIN
	IF NEW.nurse_id IS NULL THEN
		SIGNAL SQLSTATE '10500' SET MESSAGE_TEXT = 'A nurse is required to add a medication';
	END IF;
END//

CREATE TRIGGER update_inst_description
AFTER UPDATE ON execution
FOR EACH ROW
BEGIN
    IF NEW.exc_status = 'CANCELLED' THEN
        UPDATE instructions
        SET inst_description = 'CANCELLED INSTRUCTION'
        WHERE instruction_code = NEW.instruction_code;
    END IF;
END//

CREATE TRIGGER update_room_fee
AFTER UPDATE ON room
FOR EACH ROW
BEGIN
    IF NEW.one_night_fee <> OLD.one_night_fee THEN
        UPDATE invoice
        SET room_fee = NEW.one_night_fee
        WHERE patient_id = NEW.patient_id;
    END IF;
END//

CREATE TRIGGER update_instruction_fee
AFTER UPDATE ON instructions
FOR EACH ROW
BEGIN
    IF NEW.fee <> OLD.fee THEN
        UPDATE invoice
        SET instruction_fee = NEW.fee
        WHERE patient_id = NEW.patient_id;
    END IF;
END//
DELIMITER ;

#SQL Views
CREATE VIEW med_list AS
SELECT med_name, dosage, nurse_name 
FROM medicine INNER JOIN nurse ON medicine.nurse_id = nurse.nurse_id;

CREATE VIEW patient_physician AS
SELECT patient_name, physician_name
FROM patient JOIN physician ON patient.physician_id = physician.physician_id;

CREATE VIEW invoices_sum_payments AS SELECT invoice_id, SUM(amount) AS sum_payments 
FROM payment GROUP BY invoice_id;
SELECT * FROM invoices_sum_payments;

#SQL Transactions
START TRANSACTION; 
INSERT INTO patient (patient_id, patient_name, address, phone_number, physician_id, room_num) VALUES ('EYAZJ00L', 'Lucy Arasaka', '1298 St. Gabriels Chapel', '206-456-7890', 'CTVSMINNH7EB', '401-B'); 
INSERT INTO health_record (patient_id, rec_date, disease, hrecord_description, pat_status) VALUES ('EYAZJ00L', '2021-11-07', 'Diabetes', 'Patient with Type 2 Diabetes', 'BEING TREATED'); 
COMMIT; 


START TRANSACTION; 
UPDATE room SET one_night_fee = 7550 WHERE room_num = '401-B'; 
UPDATE invoice SET room_fee = 7550 WHERE room_num = '401-B'; 
COMMIT; s
