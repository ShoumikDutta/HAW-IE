
create table Actor(A_ID int PRIMARY KEY, A_name varchar(20)not null, DateofBirth char(10) not null);

create table Director (D_id int CONSTRAINT d_pk PRIMARY KEY, 
a_id_fk int constraint fk_2_a references Actor not null unique,
D_name varchar (20) not null,
Oscar_won int ,
Company varchar (50) );  

create table Producer (P_ID int CONSTRAINT prod_pk PRIMARY KEY,
prod_name varchar (20) not null,
Company varchar (50),
a_id_fk int constraint fk_p_2_a  references Actor  );


create table Movie(M_ID int CONSTRAINT m_pk PRIMARY KEY,
D_id_fk int constraint fk_2_d references Director not null unique,
title varchar(20) not null unique,
movieyear char(4) not null);

create table performs( a_id_fk int constraint fk_perf_2_a  references Actor not null,
M_id_fk int constraint fk_perf_2_m references movie not null
);

create table leadRole(a_id_fk int constraint fk_ld_2_a  references Actor not null,
M_id_fk int constraint fk_ld_2_m references movie not null);

create table Produces(p_id_fk int constraint fk_produces_2_producer  references producer not null,
M_id_fk int constraint fk_produces_2_m references movie not null);


--insert into Actor ( A_ID, A_name, DateofBirth)
--values(4,'someone','1976-04-06');

--Create index i_a on producer(2);
--create index i_b on movie(title);
--drop index i_a;
--create index i_c on movie where title is nul
