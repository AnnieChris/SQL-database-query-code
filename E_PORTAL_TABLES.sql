CREATE TABLE PORTAL_USER(
	USER_ID varchar(10) PRIMARY KEY,
	NAME varchar(50) NOT NULL,
	EMAIL varchar(30) NOT NULL,
	PASSWORD varchar(20) NOT NULL,
	ADDRESS varchar(100) NULL,
	REG_DATE datetime NULL,
	PHONE INT NULL,
	UPLOAD_PHOTO varchar(120) NULL
);

CREATE TABLE CONTACT(
	CONTACT_ID varchar(10) PRIMARY KEY,
	USER_ID varchar(10),
	NAME varchar(50) NOT NULL,
	EMAIL varchar(30) NULL,
	MESSAGE varchar(20) NULL,
	PHONE INT NULL
);
ALTER TABLE CONTACT  ADD  CONSTRAINT FK_CONTACT_USER FOREIGN KEY(USER_ID)
REFERENCES PORTAL_USER (USER_ID);

CREATE TABLE FEEDBACK(
	FEEDBACK_ID varchar(10) PRIMARY KEY,
	USER_ID varchar(10),
	NAME varchar(50) NOT NULL,
	EMAIL varchar(30) NULL,
	FEEDBACK varchar(350) NULL
);
ALTER TABLE FEEDBACK ADD  CONSTRAINT FK_FEEDBACK_USER FOREIGN KEY(USER_ID)
REFERENCES PORTAL_USER (USER_ID);

CREATE TABLE ADMIN(
	ADMIN_ID varchar(10) PRIMARY KEY,
	NAME varchar(50) NOT NULL,
	EMAIL varchar(30) NULL,
	PASSWORD varchar(20) NOT NULL
);

CREATE TABLE COURSE(
	COURSE_ID varchar(10) PRIMARY KEY,
	ADMIN_ID varchar(10),
	COURSE_NAME varchar(50) NOT NULL,
	COURSE_RESOURCE varchar(150) NULL,
	COURSE_DESC varchar(150) NULL,	
	COURSE_FEE INT
);
ALTER TABLE COURSE ADD  CONSTRAINT FK_COURSE_ADMIN FOREIGN KEY(ADMIN_ID)
REFERENCES ADMIN (ADMIN_ID);

CREATE TABLE USER_COURSE(
	COURSE_ID varchar(10),
	USER_ID varchar(10),
	STATUS varchar(10)
);
ALTER TABLE USER_COURSE ADD  CONSTRAINT FK_USER_COURSE_COURSE FOREIGN KEY(COURSE_ID)
REFERENCES COURSE (COURSE_ID);
ALTER TABLE USER_COURSE ADD  CONSTRAINT FK_USER_COURSE_USER FOREIGN KEY(USER_ID)
REFERENCES PORTAL_USER (USER_ID);