DROP TABLE Person;

CREATE TABLE Person(

Name1 VARCHAR2(255) NOT NULL CONSTRAINT pk_name PRIMARY KEY,

Birthday DATE NOT NULL,

Day_of_death DATE NULL,

Father VARCHAR2(255) NULL, 

Mother VARCHAR2(255) NULL,

FOREIGN KEY (Father) REFERENCES Person(Name1),

FOREIGN KEY (Mother) REFERENCES Person(Name1)
);

INSERT INTO Person VALUES('Rich', TO_DATE('19-04-1935', 'DD-MM-YYYY'),
                                  NULL,NULL,NULL);

INSERT INTO Person VALUES('Sue', TO_DATE('13-05-1940', 'DD-MM-YYYY'),
                                  TO_DATE('28-05-2002', 'DD-MM-YYYY'),
                                  NULL,NULL);
                         
INSERT INTO Person VALUES('Walt', TO_DATE('10-03-1930', 'DD-MM-YYYY'),
                                  TO_DATE('20-12-2007', 'DD-MM-YYYY'),
                                  NULL,NULL);                              
                                  
INSERT INTO Person VALUES('Ellen', TO_DATE('09-09-1930', 'DD-MM-YYYY'),
                                  NULL,NULL,NULL);
                                  
INSERT INTO Person VALUES('Bob', TO_DATE('11-11-1965', 'DD-MM-YYYY'),
                                  NULL,'Walt','Ellen');
                                  
INSERT INTO Person VALUES('Susan', TO_DATE('08-08-1966', 'DD-MM-YYYY'),
                                  NULL,'Rich','Sue');
                                  
INSERT INTO Person VALUES('Jane', TO_DATE('01-01-2006', 'DD-MM-YYYY'),
                                  NULL,'Bob','Susan');
                                  
INSERT INTO Person VALUES('Joe', TO_DATE('02-02-2007', 'DD-MM-YYYY'),
                                  NULL,'Bob','Susan');                                                                                              
                                  
COMMIT;                                  