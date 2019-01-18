class CompanyController < ApplicationController
  def index
    companies = Company.all
    respond_with 200 do
      json companies.to_json
    end
  end

  def show
    if company = Company.find params["id"]
      respond_with 200 do
        json company.to_json
      end
    else
      results = {status: "not found"}
      respond_with 404 do
        json results.to_json
      end
    end
  end

  def create
    company = Company.new(company_params.validate!)

    if company.valid? && company.save
      respond_with 201 do
        json company.to_json
      end
    else
        results = {status: "invalid"}
        respond_with 422 do
          json results.to_json
        end
    end
  end

  def update
    if company = Company.find(params["id"])
      company.set_attributes(company_params.validate!)
      if company.valid? && company.save
        respond_with 200 do
          json company.to_json
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
    if company = Company.find params["id"]
      company.destroy
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

  def company_params
    params.validation do
      required(:name) { |f| !f.nil? }
      required(:city) { |f| !f.nil? }
      required(:state) { |f| !f.nil? }
      required(:logo) { |f| !f.nil? }
    end
  end
end
