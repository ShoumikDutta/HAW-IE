CREATE TABLE Actor(A_id int CONSTRAINT a_pk PRIMARY KEY, 
A_name varchar(20)not null, 
DateofBirth char(10) not null);

CREATE TABLE Director (D_id int CONSTRAINT d_pk PRIMARY KEY, 
a_id_fk int constraint fk_2_a references Actor not null unique,
D_name varchar (20) not null,
Oscar_won int ,
Company varchar (50) );  

CREATE TABLE Producer (P_id int CONSTRAINT prod_pk PRIMARY KEY,
prod_name varchar (20) not null,
Company varchar (50),
a_id_fk int constraint fk_p_2_a  references Actor not null unique  );


CREATE TABLE Movie(M_id int CONSTRAINT m_pk PRIMARY KEY,
D_id_fk int constraint fk_2_d references Director not null unique,
title varchar(20) not null unique,
movie_year char(4) not null,
budget numeric(20,2),
country_of_production varchar(20) not null,
movie_genre varchar(20) not null
);

CREATE TABLE performs_in( a_id_fk int constraint fk_perf_2_a  references Actor not null,
M_id_fk int constraint fk_perf_2_m references movie not null
);

CREATE TABLE lead_Role(a_id_fk int constraint fk_ld_2_a  references Actor not null,
M_id_fk int constraint fk_ld_2_m references movie not null);
CREATE TABLE Produces(p_id_fk int constraint fk_produces_2_producer  references producer not null,
M_id_fk int constraint fk_produces_2_m references movie not null);
