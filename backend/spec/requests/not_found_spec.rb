require "rails_helper"

RSpec.describe "Not found", type: :request do
  before do
    expect_any_instance_of(ApplicationController)
      .to receive(:authorize_access_request!)
      .and_return(true)
  end

  describe "GET /asdasdasasasddasasdasdasd" do
    subject! { get "/asdasdasasasddasasdasdasd" }

    it "returns a validation failure message" do
      expect(response).to have_http_status(404)
    end

    it "returns a validation failure message" do
      expect(json["error"]).to eq "Not found"
    end
  end
end
