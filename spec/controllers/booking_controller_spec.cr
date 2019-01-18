require "./spec_helper"

def booking_hash
  {"user_id" => "1", "conference_room_id" => "1", "agenda" => "Fake", "booking_on" => "2019-01-18 16:39:37 +05:30", "start_time" => "2019-01-18 16:39:37 +05:30", "end_time" => "2019-01-18 16:39:37 +05:30", "status" => "Fake", "description" => "Fake"}
end

def booking_params
  params = [] of String
  params << "user_id=#{booking_hash["user_id"]}"
  params << "conference_room_id=#{booking_hash["conference_room_id"]}"
  params << "agenda=#{booking_hash["agenda"]}"
  params << "booking_on=#{booking_hash["booking_on"]}"
  params << "start_time=#{booking_hash["start_time"]}"
  params << "end_time=#{booking_hash["end_time"]}"
  params << "status=#{booking_hash["status"]}"
  params << "description=#{booking_hash["description"]}"
  params.join("&")
end

def create_booking
  model = Booking.new(booking_hash)
  model.save
  model
end

class BookingControllerTest < GarnetSpec::Controller::Test
  getter handler : Amber::Pipe::Pipeline

  def initialize
    @handler = Amber::Pipe::Pipeline.new
    @handler.build :api do
      plug Amber::Pipe::Error.new
      plug Amber::Pipe::Session.new
    end
    @handler.prepare_pipelines
  end
end

describe BookingControllerTest do
  subject = BookingControllerTest.new

  it "renders booking index json" do
    Booking.clear
    model = create_booking
    response = subject.get "/bookings"

    response.status_code.should eq(200)
    response.body.should contain("Fake")
  end

  it "renders booking show json" do
    Booking.clear
    model = create_booking
    location = "/bookings/#{model.id}"

    response = subject.get location

    response.status_code.should eq(200)
    response.body.should contain("Fake")
  end

  it "creates a booking" do
    Booking.clear
    response = subject.post "/bookings", body: booking_params

    response.status_code.should eq(201)
    response.body.should contain "Fake"
  end

  it "updates a booking" do
    Booking.clear
    model = create_booking
    response = subject.patch "/bookings/#{model.id}", body: booking_params

    response.status_code.should eq(200)
    response.body.should contain "Fake"
  end

  it "deletes a booking" do
    Booking.clear
    model = create_booking
    response = subject.delete "/bookings/#{model.id}"

    response.status_code.should eq(204)
  end
end