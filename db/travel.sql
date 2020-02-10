DROP TABLE cities;
DROP TABLE countries;

CREATE TABLE countries
(
  id SERIAL primary key,
  name VARCHAR(255)
);

CREATE TABLE cities
(
  id SERIAL primary key,
  name VARCHAR(255)
);
