class BookingController < ApplicationController
  def index
    bookings = Booking.all
    respond_with 200 do
      json bookings.to_json
    end
  end

  def show
    if booking = Booking.find params["id"]
      respond_with 200 do
        json booking.to_json
      end
    else
      results = {status: "not found"}
      respond_with 404 do
        json results.to_json
      end
    end
  end

  def create
    booking = Booking.new(booking_params.validate!)

    if booking.valid? && booking.save
      respond_with 201 do
        json booking.to_json
      end
    else
        results = {status: "invalid"}
        respond_with 422 do
          json results.to_json
        end
    end
  end

  def update
    if booking = Booking.find(params["id"])
      booking.set_attributes(booking_params.validate!)
      if booking.valid? && booking.save
        respond_with 200 do
          json booking.to_json
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
    if booking = Booking.find params["id"]
      booking.destroy
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

  def booking_params
    params.validation do
      required(:user_id) { |f| !f.nil? }
      required(:conference_room_id) { |f| !f.nil? }
      required(:agenda) { |f| !f.nil? }
      required(:booking_on) { |f| !f.nil? }
      required(:start_time) { |f| !f.nil? }
      required(:end_time) { |f| !f.nil? }
      required(:status) { |f| !f.nil? }
      required(:description) { |f| !f.nil? }
    end
  end
end
