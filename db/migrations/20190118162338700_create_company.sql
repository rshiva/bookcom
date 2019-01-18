-- +micrate Up
CREATE TABLE companies (
  id BIGSERIAL PRIMARY KEY,
  name VARCHAR,
  city VARCHAR,
  state VARCHAR,
  logo VARCHAR,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);


-- +micrate Down
DROP TABLE IF EXISTS companies;
