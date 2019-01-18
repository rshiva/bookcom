-- +micrate Up
CREATE TABLE users (
  id BIGSERIAL PRIMARY KEY,
  email VARCHAR,
  company_id BIGINT,
  employee_code VARCHAR,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);
CREATE INDEX user_company_id_idx ON users (company_id);

-- +micrate Down
DROP TABLE IF EXISTS users;
