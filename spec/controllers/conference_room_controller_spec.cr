require "./spec_helper"

def conference_room_hash
  {"name" => "Fake", "capacity" => "1", "accessories" => "Fake", "company_id" => "1"}
end

def conference_room_params
  params = [] of String
  params << "name=#{conference_room_hash["name"]}"
  params << "capacity=#{conference_room_hash["capacity"]}"
  params << "accessories=#{conference_room_hash["accessories"]}"
  params << "company_id=#{conference_room_hash["company_id"]}"
  params.join("&")
end

def create_conference_room
  model = ConferenceRoom.new(conference_room_hash)
  model.save
  model
end

class ConferenceRoomControllerTest < GarnetSpec::Controller::Test
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

describe ConferenceRoomControllerTest do
  subject = ConferenceRoomControllerTest.new

  it "renders conference_room index json" do
    ConferenceRoom.clear
    model = create_conference_room
    response = subject.get "/conference_rooms"

    response.status_code.should eq(200)
    response.body.should contain("Fake")
  end

  it "renders conference_room show json" do
    ConferenceRoom.clear
    model = create_conference_room
    location = "/conference_rooms/#{model.id}"

    response = subject.get location

    response.status_code.should eq(200)
    response.body.should contain("Fake")
  end

  it "creates a conference_room" do
    ConferenceRoom.clear
    response = subject.post "/conference_rooms", body: conference_room_params

    response.status_code.should eq(201)
    response.body.should contain "Fake"
  end

  it "updates a conference_room" do
    ConferenceRoom.clear
    model = create_conference_room
    response = subject.patch "/conference_rooms/#{model.id}", body: conference_room_params

    response.status_code.should eq(200)
    response.body.should contain "Fake"
  end

  it "deletes a conference_room" do
    ConferenceRoom.clear
    model = create_conference_room
    response = subject.delete "/conference_rooms/#{model.id}"

    response.status_code.should eq(204)
  end
end