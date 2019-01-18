-- +micrate Up
CREATE TABLE bookings (
  id BIGSERIAL PRIMARY KEY,
  user_id BIGINT,
  conference_room_id BIGINT,
  agenda VARCHAR,
  booking_on DATE,
  start_time TIMESTAMP,
  end_time TIMESTAMP,
  status VARCHAR,
  description TEXT,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);
CREATE INDEX booking_user_id_idx ON bookings (user_id);
CREATE INDEX booking_conference_room_id_idx ON bookings (conference_room_id);

-- +micrate Down
DROP TABLE IF EXISTS bookings;
