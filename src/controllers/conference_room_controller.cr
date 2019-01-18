class ConferenceRoomController < ApplicationController
  def index
    conference_rooms = ConferenceRoom.all
    respond_with 200 do
      json conference_rooms.to_json
    end
  end

  def show
    if conference_room = ConferenceRoom.find params["id"]
      respond_with 200 do
        json conference_room.to_json
      end
    else
      results = {status: "not found"}
      respond_with 404 do
        json results.to_json
      end
    end
  end

  def create
    conference_room = ConferenceRoom.new(conference_room_params.validate!)

    if conference_room.valid? && conference_room.save
      respond_with 201 do
        json conference_room.to_json
      end
    else
        results = {status: "invalid"}
        respond_with 422 do
          json results.to_json
        end
    end
  end

  def update
    if conference_room = ConferenceRoom.find(params["id"])
      conference_room.set_attributes(conference_room_params.validate!)
      if conference_room.valid? && conference_room.save
        respond_with 200 do
          json conference_room.to_json
        end
      else
        results = {status: "invalid"}
        respond_with 422 do
          json results.to_json
        end
      end
    else
      results = {status: "not found"}
      respond_with 404 do
        json results.to_json
      end
    end
  end

  def destroy
    if conference_room = ConferenceRoom.find params["id"]
      conference_room.destroy
      respond_with 204 do
        json ""
      end
    else
      results = {status: "not found"}
      respond_with 404 do
        json results.to_json
      end
    end
  end

  def conference_room_params
    params.validation do
      required(:name) { |f| !f.nil? }
      required(:capacity) { |f| !f.nil? }
      required(:accessories) { |f| !f.nil? }
      required(:company_id) { |f| !f.nil? }
    end
  end
end
