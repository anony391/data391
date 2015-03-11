INSERT INTO persons (person_id, first_name, last_name, address, email, phone) VALUES (personID_sequence.nextval,'Carly','Chan','00001-001st','carlychan@cmput391.ca','0000000001');
INSERT INTO persons (person_id, first_name, last_name, address, email, phone) VALUES (personID_sequence.nextval,'Ruby','DeJesus','00002-002st','rubydejesus@cmput391.ca','0000000002');
INSERT INTO persons (person_id, first_name, last_name, address, email, phone) VALUES (personID_sequence.nextval,'Perry','Carpenter','00003-003st','perrycarpenter@cmput391.ca','0000000003');
INSERT INTO persons (person_id, first_name, last_name, address, email, phone) VALUES (personID_sequence.nextval,'Toni','Abbott','00004-004st','toniabbott@cmput391.ca','0000000004');
INSERT INTO persons (person_id, first_name, last_name, address, email, phone) VALUES (personID_sequence.nextval,'Edna','White','00005-005st','MurielPierce@cmput391.ca','0000000005');
INSERT INTO persons (person_id, first_name, last_name, address, email, phone) VALUES (personID_sequence.nextval,'Winston','Daniels','00006-006st','winstondaniels@cmput391.ca','0000000006');
INSERT INTO persons (person_id, first_name, last_name, address, email, phone) VALUES (personID_sequence.nextval,'Eunice','Miles','00007-007st','eunicemiles@cmput391.ca','0000000007');

INSERT INTO users (user_name, password, class, person_id, date_registered) VALUES ('CarlyChanAdmin','CarlyCA','a',000000001,to_date('1995-03-04', 'yyyy-mm-dd'));
INSERT INTO users (user_name, password, class, person_id, date_registered) VALUES ('RubyDeJesusAdmin','RubyDJA','a',000000002,to_date('1995-03-04', 'yyyy-mm-dd'));
INSERT INTO users (user_name, password, class, person_id, date_registered) VALUES ('PerryCarpenter12','PerryC12','p',000000003,to_date('1997-01-01', 'yyyy-mm-dd'));
INSERT INTO users (user_name, password, class, person_id, date_registered) VALUES ('ToniAbbott65','ToniA65','p',000000004,to_date('1997-10-26', 'yyyy-mm-dd'));
INSERT INTO users (user_name, password, class, person_id, date_registered) VALUES ('EdnaWhite38','EdnaW38','r',000000005,to_date('1998-07-15', 'yyyy-mm-dd'));
INSERT INTO users (user_name, password, class, person_id, date_registered) VALUES ('WinstonDaniels54','WinstonD54','d',000000006,to_date('1998-02-28', 'yyyy-mm-dd'));
INSERT INTO users (user_name, password, class, person_id, date_registered) VALUES ('EuniceMiles73','EuniceM73','d',000000007,to_date('1996-05-12', 'yyyy-mm-dd'));

INSERT INTO family_doctor (doctor_id, patient_id) VALUES (000000006,000000001);
INSERT INTO family_doctor (doctor_id, patient_id) VALUES (000000006,000000002);
INSERT INTO family_doctor (doctor_id, patient_id) VALUES (000000006,000000003);
INSERT INTO family_doctor (doctor_id, patient_id) VALUES (000000006,000000004);
INSERT INTO family_doctor (doctor_id, patient_id) VALUES (000000007,000000005);


