DROP TABLE cities;
DROP TABLE countries;

CREATE TABLE countries
(
  id SERIAL primary key,
  name VARCHAR(255),
  visited BOOLEAN
);

CREATE TABLE cities
(
  id SERIAL primary key,
  name VARCHAR(255),
  country_id INT4 references countries(id) ON DELETE CASCADE,
  visited BOOLEAN
);
