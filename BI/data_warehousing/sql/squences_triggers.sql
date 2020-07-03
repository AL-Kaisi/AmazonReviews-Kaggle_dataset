CREATE SEQUENCE R_Time_PK
START WITH 1
INCREMENT BY 1
CACHE 10;

CREATE SEQUENCE P_PHONE_PK
START WITH 1
INCREMENT BY 1
CACHE 10;

CREATE OR REPLACE TRIGGER RP_Phone_PK
BEFORE INSERT
ON Dim_Phone
REFERENCING NEW AS NEW
FOR EACH ROW
BEGIN
  IF(:NEW.Id IS NULL) THEN
  SELECT P_PHONE_PK.NEXTVAL
  INTO :NEW.Id
  FROM dual;
  END IF;
END;

CREATE OR REPLACE TRIGGER RT_Time_PK
BEFORE INSERT
ON Dim_Time
REFERENCING NEW AS NEW
FOR EACH ROW
BEGIN
  IF(:NEW.time_ID IS NULL) THEN
  SELECT R_Time_PK.NEXTVAL
  INTO :NEW.time_ID
  FROM dual;
  END IF;
END;