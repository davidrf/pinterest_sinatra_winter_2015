DROP TABLE IF EXISTS pins;

CREATE TABLE pins(
  id SERIAL PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  description VARCHAR(255)
);
