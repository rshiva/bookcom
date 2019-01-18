-- +micrate Up
CREATE TABLE conference_rooms (
  id BIGSERIAL PRIMARY KEY,
  name VARCHAR,
  capacity INT,
  accessories VARCHAR,
  company_id BIGINT,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);
CREATE INDEX conference_room_company_id_idx ON conference_rooms (company_id);

-- +micrate Down
DROP TABLE IF EXISTS conference_rooms;
