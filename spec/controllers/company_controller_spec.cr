require "./spec_helper"

def company_hash
  {"name" => "Fake", "city" => "Fake", "state" => "Fake", "logo" => "Fake"}
end

def company_params
  params = [] of String
  params << "name=#{company_hash["name"]}"
  params << "city=#{company_hash["city"]}"
  params << "state=#{company_hash["state"]}"
  params << "logo=#{company_hash["logo"]}"
  params.join("&")
end

def create_company
  model = Company.new(company_hash)
  model.save
  model
end

class CompanyControllerTest < GarnetSpec::Controller::Test
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

describe CompanyControllerTest do
  subject = CompanyControllerTest.new

  it "renders company index json" do
    Company.clear
    model = create_company
    response = subject.get "/companies"

    response.status_code.should eq(200)
    response.body.should contain("Fake")
  end

  it "renders company show json" do
    Company.clear
    model = create_company
    location = "/companies/#{model.id}"

    response = subject.get location

    response.status_code.should eq(200)
    response.body.should contain("Fake")
  end

  it "creates a company" do
    Company.clear
    response = subject.post "/companies", body: company_params

    response.status_code.should eq(201)
    response.body.should contain "Fake"
  end

  it "updates a company" do
    Company.clear
    model = create_company
    response = subject.patch "/companies/#{model.id}", body: company_params

    response.status_code.should eq(200)
    response.body.should contain "Fake"
  end

  it "deletes a company" do
    Company.clear
    model = create_company
    response = subject.delete "/companies/#{model.id}"

    response.status_code.should eq(204)
  end
end