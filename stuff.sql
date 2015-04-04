CREATE INDEX search ON radiology_record(diagnosis) INDEXTYPE IS CTXSYS.CONTEXT;

Index created.

SQL> CREATE INDEX search1 ON radiology_record(description) INDEXTYPE IS CTXSYS.CONTEXT;



CREATE INDEX search2 ON persons(first_name) INDEXTYPE IS CTXSYS.CONTEXT;

SQL> CREATE VIEW patientname_radiology          
  2  AS
  3  SELECT p.first_name, p.last_name, r.record_id FROM
  4  radiology_record r, persons p WHERE p.person_id = r.patient_id;
SQL> CREATE INDEX item ON persons(last_name) INDEXTYPE IS CTXSYS.CONTEXT;
SQL> CREATE INDEX search2 ON persons(first_name) INDEXTYPE IS CTXSYS.CONTEXT;


