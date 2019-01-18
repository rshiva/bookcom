class Company < Granite::Base
  adapter pg
  table_name companies

  has_many :users
  has_many :conference_rooms

  primary id : Int64
  field name : String
  field city : String
  field state : String
  field logo : String
  timestamps
end
