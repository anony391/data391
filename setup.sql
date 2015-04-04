CREATE SEQUENCE personID_sequence 
start with 0000000001
increment by 1
minvalue 0000000001
maxvalue 9999999999; 

CREATE OR REPLACE VIEW analysis_view AS 
SELECT p.first_name, p.last_name,r.test_type, r.test_date, i.image_id 
FROM persons p, radiology_record r, pacs_images i 
WHERE p.person_id=r.patient_id AND i.record_id=r.record_id;

CREATE INDEX search ON radiology_record(diagnosis) INDEXTYPE IS CTXSYS.CONTEXT;

Index created.

CREATE INDEX search1 ON radiology_record(description) INDEXTYPE IS CTXSYS.CONTEXT;



CREATE INDEX search2 ON persons(first_name) INDEXTYPE IS CTXSYS.CONTEXT;

CREATE VIEW patientname_radiology AS
SELECT p.first_name, p.last_name, r.record_id
FROM radiology_record r, persons p WHERE p.person_id = r.patient_id;

CREATE INDEX item ON persons(last_name) INDEXTYPE IS CTXSYS.CONTEXT;
CREATE INDEX search2 ON persons(first_name) INDEXTYPE IS CTXSYS.CONTEXT;


