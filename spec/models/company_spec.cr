require "./spec_helper"
require "../../src/models/company.cr"

describe Company do
  Spec.before_each do
    Company.clear
  end
end
