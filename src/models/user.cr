class User < Granite::Base
  adapter pg
  table_name users

  belongs_to :company
  has_many :bookings

  primary id : Int64
  field email : String
  field employee_code : String
  timestamps
end
