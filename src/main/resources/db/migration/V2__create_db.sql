ALTER TABLE USER ADD COLUMN PASSWORD VARCHAR(100) NOT NULL;

CREATE TABLE AUTHORITY(  
  ID INT NOT NULL AUTO_INCREMENT,
  NAME VARCHAR(50) NOT NULL,
  PRIMARY KEY (ID)
);

CREATE TABLE USER_AUTHORITY(  
  ID INT NOT NULL AUTO_INCREMENT,
  USER_ID INT NOT NULL,
  AUTHORITY_ID INT NOT NULL,
  PRIMARY KEY (ID),
  FOREIGN KEY (USER_ID) REFERENCES USER(ID),
  FOREIGN KEY (AUTHORITY_ID) REFERENCES AUTHORITY(ID)
);

CREATE TABLE TASK(  
  ID INT NOT NULL AUTO_INCREMENT,
  TITLE VARCHAR(50) NOT NULL,
  DESCRIPTION VARCHAR(200),
  CREATED_BY INT NOT NULL,
  LAST_MODIFIED_BY INT NOT NULL,
  DATE_CREATED TIMESTAMP NOT NULL,
  LAST_UPDATED TIMESTAMP NOT NULL,
  PRIMARY KEY (ID),
  FOREIGN KEY (CREATED_BY) REFERENCES USER(ID),
  FOREIGN KEY (LAST_MODIFIED_BY) REFERENCES USER(ID)
);

INSERT INTO USER (FIRSTNAME, LASTNAME, EMAIL, MOBILE_NO, PASSWORD) VALUES ('admin', 'admin', 'admin@boot.com', '9999999999', '$2a$10$Oxm9zeWvkD9oa5yeZJ5T5eZhM4VFcrzcrwtYfQJoBzlkqmkeiZo.2');
INSERT INTO USER (FIRSTNAME, LASTNAME, EMAIL, MOBILE_NO, PASSWORD) VALUES ('user', 'user', 'user@boot.com', '9898989898', '$2a$10$pKqV1oABeq01SemLGufQ/.bHO4W0olykC.KQ.99rKhjHQ0RQt4e7m');
INSERT INTO AUTHORITY (NAME) VALUES ('ROLE_USER');
INSERT INTO AUTHORITY (NAME) VALUES ('ROLE_ADMIN');
INSERT INTO AUTHORITY (NAME) VALUES ('ROLE_ANONYMOUS');
INSERT INTO USER_AUTHORITY SET USER_ID = (SELECT id FROM USER WHERE EMAIL = 'admin@boot.com'), AUTHORITY_ID = (SELECT id FROM AUTHORITY WHERE NAME = 'ROLE_ADMIN');
INSERT INTO USER_AUTHORITY SET USER_ID = (SELECT id FROM USER WHERE EMAIL = 'admin@boot.com'), AUTHORITY_ID = (SELECT id FROM AUTHORITY WHERE NAME = 'ROLE_USER');
INSERT INTO USER_AUTHORITY SET USER_ID = (SELECT id FROM USER WHERE EMAIL = 'user@boot.com'), AUTHORITY_ID = (SELECT id FROM AUTHORITY WHERE NAME = 'ROLE_USER');