class ConferenceRoom < Granite::Base
  adapter pg
  table_name conference_rooms

  belongs_to :company
  has_many :bookings

  primary id : Int64
  field name : String
  field capacity : Int32
  field accessories : String
  timestamps
end
