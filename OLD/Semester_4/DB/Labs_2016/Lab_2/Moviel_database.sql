CREATE TABLE actor (
aid INTEGER NOT NULL CONSTRAINT actor_id PRIMARY KEY
)?
CREATE TABLE director (
did INTEGER NOT NULL CONSTRAINT director_id PRIMARY KEY
)?
CREATE TABLE producer (
pid INTEGER NOT NULL CONSTRAINT producer_id PRIMARY KEY
)?
CREATE TABLE movie (
mid INTEGER NOT NULL CONSTRAINT movie_id PRIMARY KEY,
director INTEGER CONSTRAINT fk_movie_director REFERENCES
director(did)
)?
CREATE TABLE performs (
actor INTEGER CONSTRAINT fk_actor_ REFERENCES actor(aid),
performs_in INTEGER CONSTRAINT fk_acts_in REFERENCES movie(mid)
)?
CREATE TABLE lead_role (
main_actor INTEGER CONSTRAINT fk_lead_actor REFERENCES actor(aid),
lead_role_in INTEGER CONSTRAINT fk_lead_in REFERENCES movie(mid)
)?
CREATE TABLE produces (
producer INTEGER CONSTRAINT fk_producer_id REFERENCES producer(pid),
movie_produced INTEGER CONSTRAINT fk_movie_produced REFERENCES
movie(mid)
)?
CREATE TABLE also_producer (
producer_id INTEGER CONSTRAINT fk_producer_actor REFERENCES
producer(pid),
actor_id INTEGER CONSTRAINT fk_actor_producer REFERENCES actor(aid)
)?
CREATE TABLE also_director (
director_id INTEGER NOT NULL CONSTRAINT fk_director_actor REFERENCES
director(did),
actor_id INTEGER NOT NULL CONSTRAINT fk_actor_director REFERENCES
actor(aid)
)?

