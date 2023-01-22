INSERT INTO room(room_num, capacity, one_night_fee) VALUES
('104-A', 12, 5000),
('107-C', 8, 3800),
('228-B', 20, 8000), 
('303-D', 25, 9200), 
('510-A', 50, 12400);

INSERT INTO physician(physician_id, physician_name, certification_number, expertise_field, address, phone_number) VALUES 
('SHWSFXLC57UV', 'Ryan Johnson', '711BQPHGY14O', 'Pediatrics', '342 Honeysuckle Lane', '206-300-1496'), 
('41NC9W1BYTQT', 'Emily Walker', 'I80HVSFW454L', 'Gastrology', '4030 Owagner Lane', '206-810-1981'), 
('P9FFRB8ODKJ2', 'Justin Zhang', 'ZK41NKY0YS4P', 'Emergency Medicine', '4653 Conifer Drive', '206-442-6583'),
('8PWPJ839VTYV', 'Alison Zekpta', 'DVXZT6R2D4KI', 'Surgery', '1165 Dale Avenue', '206-458-4060'),
('SHRL97IDC75F', 'Joe Whatzzit', '99NO4O0G9VE6', 'Phychiatry', '3549 Chardonnay Drive', '206-276-3707');

INSERT INTO nurse(nurse_id, nurse_name, certification_number, address, phone_number) VALUES
('HF1HJE7SBA50', 'Jill James', '05TVIJ1WJHMG', '3772 Dale Avenue', '206-201-5636'),
('AE2QHHH5I1WS', 'Omar Wilkins', 'BXBDFWG8WDN9', '4258 Terra Street', '206-608-8116'),
('HAXR6OAHYIES', 'Andrew Rando', '8907LWZW67DF', '1227 Union Street', '206-605-6696'),
('6G4GC1UUCA4P', 'Jamie Smiths', '7BL7374O0NKC', '3732 Fort Street', '206-817-4098'),
('XTHEOSUWFQ2E', 'Andrea Chess', 'UJJHQ3R3VWTZ', '1103 Owagner Lane', '206-535-0512');

INSERT INTO patient(patient_id, patient_name, address, phone_number, physician_id, room_num) VALUES
('W1WKW8UZ', 'Aadil Tucker', '4952 Union Street', '206-643-3768', '41NC9W1BYTQT', '228-B'),
('NWTL3BZM', 'Shaunie Foreman', '3842 University Street', '206-436-8176', 'SHRL97IDC75F', '510-A'), 
('A5SU0YQA', 'Carson Bower', '4988 Elliot Avenue', '206-604-6486', '8PWPJ839VTYV', '303-D'),
('Z50GCO4R', 'Polly Watts', '751 Dale Avenue', '206-427-1002', 'P9FFRB8ODKJ2', '104-A'),
('J46ZNY66', 'Wade Watts', '751 Dale Avenue', '206-973-8651', 'P9FFRB8ODKJ2', '107-C');

INSERT INTO medicine(med_name, dosage, patient_id, nurse_id) VALUES
('Amitriptyline', '75mg', 'NWTL3BZM', 'AE2QHHH5I1WS'),
('Omeprazole','30mg','W1WKW8UZ', '6G4GC1UUCA4P'),
('Oxycodone', '9mg', 'Z50GCO4R', 'XTHEOSUWFQ2E'), 
('Warfarin', '100mg', 'J46ZNY66', 'HAXR6OAHYIES'),
('Azathioprine','75mg','A5SU0YQA','HF1HJE7SBA50');

INSERT INTO instructions(instruction_code, fee, inst_description, order_date, physician_id, patient_id) VALUES
('850567955817936', 323.40, 'Perform X-Ray on Patient to ensure stability', '2022-11-05', 'P9FFRB8ODKJ2', 'Z50GCO4R'),
('707070036648263', 428.89, 'Get CT Scan to ensure no cerebral bleeding', '2022-11-05', 'P9FFRB8ODKJ2', 'J46ZNY66'),
('507249425950777', 212.20, 'Get bloodwork done to ensure proper digestive process', '2022-11-07', '41NC9W1BYTQT', 'W1WKW8UZ'),
('678947350047980', 389.95, 'Perform follow-up psych evals to gage severity', '2022-11-06', 'SHRL97IDC75F','NWTL3BZM'),
('726550746700201', 45,'Check for infection and perform post-op checklist', '2022-11-04', '8PWPJ839VTYV', 'A5SU0YQA');

INSERT INTO execution(instruction_code, patient_id, nurse_id, execution_date, exc_status) VALUES
('850567955817936', 'Z50GCO4R', '6G4GC1UUCA4P', '2022-11-05', 'COMPLETE'), 
('707070036648263', 'J46ZNY66', 'XTHEOSUWFQ2E', '2022-11-05', 'IN PROGRESS'), 
('507249425950777', 'W1WKW8UZ', 'AE2QHHH5I1WS', DEFAULT, 'CANCELLED'),
('678947350047980', 'NWTL3BZM', 'HF1HJE7SBA50', '2022-11-07', 'COMPLETE'), 
('726550746700201', 'A5SU0YQA', 'HAXR6OAHYIES', '2022-11-04', 'COMPLETE');

INSERT INTO invoice(invoice_id, room_fee, instruction_fee, patient_id) VALUES
('39Z360Z', 5000, 323.40, 'Z50GCO4R'),
('71XAO1F', 3800, 428.89, 'J46ZNY66'),
('48IF5QR', 8000, 212.20, 'W1WKW8UZ'),
('97BTUEE', 12400, 389.95, 'NWTL3BZM'),
('11FU7IK4', 9200, 45, 'A5SU0YQA');

INSERT INTO payment(payment_id, invoice_id, amount, pay_date) VALUES
('DEMJTV', '39Z360Z', 1200, '2022-11-10'),
('6HFSBI', '71XAO1F', 1200, '2022-11-10'),
('N913B9', '48IF5QR', 4500, '2022-11-09'),
('K70U0U', '97BTUEE', 7000, '2022-11-11'),
('DAVQ9C', '97BTUEE', 1000, '2022-11-12'),
('WX0HMV', '11FU7IK4', 900, '2022-11-09'),
('MXT4UG', '11FU7IK4', 256, '2022-11-10');

INSERT INTO health_record(patient_id, rec_date, disease, hrecord_description, pat_status) VALUES
('Z50GCO4R', '2022-11-06', 'Leg Fracture', 'Partial fracture of the femur', 'BEING TREATED'), 
('J46ZNY66', '2022-11-06', 'Cerebral Swelling', 'Excess blood clotting in the brain', 'BEING TREATED'),
('W1WKW8UZ', '2022-11-07', 'Esophagitis', 'Patient found with bacterial infection before bloodwork necessary', 'TREATED'), 
('NWTL3BZM', '2022-11-08', 'Schizophrenia', 'Disordered thinking and hallucination', 'BEING TREATED'),
('A5SU0YQA', '2022-11-04', 'Appendix Rupture', 'Abcess due to appendix rupture', 'TREATED');






