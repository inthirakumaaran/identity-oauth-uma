CREATE TABLE IF NOT EXISTS IDN_RESOURCE (
  ID                  INTEGER AUTO_INCREMENT NOT NULL,
  RESOURCE_ID         VARCHAR(255),
  RESOURCE_NAME       VARCHAR(255),
  TIME_CREATED        TIMESTAMP DEFAULT '0',
  RESOURCE_OWNER_NAME VARCHAR(255),
  CONSUMER_KEY        VARCHAR(255),
  TENANT_DOMAIN       VARCHAR(255),
  PRIMARY KEY (ID)
);

/*CREATE TABLE IF NOT EXISTS IDN_RESOURCE_META_DATA (
  ID                INTEGER AUTO_INCREMENT NOT NULL,
  RESOURCE_IDENTITY INTEGER NOT NULL,
  PROPERTY_KEY      VARCHAR(40),
  PROPERTY_VALUE    VARCHAR(40),
  PRIMARY KEY (ID),
  CONSTRAINT FK_RESOURCE_META_DATA FOREIGN KEY (RESOURCE_IDENTITY) REFERENCES IDN_RESOURCE (ID)
  ON DELETE CASCADE
);*/

CREATE TABLE IF NOT EXISTS IDN_RESOURCE_SCOPE (
  ID                INTEGER AUTO_INCREMENT NOT NULL,
  RESOURCE_IDENTITY INTEGER                NOT NULL,
  SCOPE_NAME        VARCHAR(255),
  PRIMARY KEY (ID),
  CONSTRAINT FK_IDN_RESOURCE FOREIGN KEY (RESOURCE_IDENTITY) REFERENCES IDN_RESOURCE (ID)
  ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS IDN_PERMISSION_TICKET (
  ID              INTEGER AUTO_INCREMENT NOT NULL,
  PT              VARCHAR(255)           NOT NULL,
  TIME_CREATED    TIMESTAMP   DEFAULT '0',
  VALIDITY_PERIOD BIGINT,
  TICKET_STATE    VARCHAR(25) DEFAULT 'ACTIVE',
  TENANT_DOMAIN   VARCHAR(255),
  PRIMARY KEY (ID)
);

CREATE TABLE IF NOT EXISTS IDN_PT_RESOURCE (
  ID       INTEGER AUTO_INCREMENT NOT NULL,
  PT_RESOURCE_ID INTEGER NOT NULL ,
  PT_ID    INTEGER NOT NULL ,
  PRIMARY KEY (ID),
  CONSTRAINT FK_PT FOREIGN KEY (PT_ID) REFERENCES IDN_PERMISSION_TICKET (ID) ON DELETE CASCADE,
  CONSTRAINT FK_PT_RESOURCE FOREIGN KEY (PT_RESOURCE_ID) REFERENCES IDN_RESOURCE (ID) ON DELETE CASCADE
);

CREATE TABLE IDN_PT_RESOURCE_SCOPE (
  ID          INTEGER AUTO_INCREMENT NOT NULL,
  PT_RESOURCE_ID INTEGER NOT NULL ,
  PT_SCOPE_ID    INTEGER NOT NULL ,
  PRIMARY KEY (ID),
  CONSTRAINT FK_PT_RESOURCE_ID FOREIGN KEY (PT_RESOURCE_ID) REFERENCES IDN_PT_RESOURCE (ID) ON DELETE CASCADE,
  CONSTRAINT FK_PT_SCOPE_ID FOREIGN KEY (PT_SCOPE_ID) REFERENCES IDN_RESOURCE_SCOPE (ID) ON DELETE CASCADE
);
