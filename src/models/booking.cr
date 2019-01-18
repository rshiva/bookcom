class Booking < Granite::Base
  adapter pg
  table_name bookings

  belongs_to :user

  belongs_to :conference_rooms

  primary id : Int64
  field agenda : String
  field booking_on : Time
  field start_time : Time
  field end_time : Time
  field status : String
  field description : String
  timestamps
end
