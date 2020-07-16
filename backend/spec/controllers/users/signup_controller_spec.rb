require "rails_helper"

RSpec.describe Users::SignupController, type: :controller do
  describe "POST #create" do
    subject { post :create, params: user_params }

    context "with valid params" do
      let(:user_params) do
        {email: "test@email.com", password: "password", password_confirmation: "password"}
      end

      it "returns http success" do
        subject

        expect(response).to be_successful
        expect(json.keys).to eq ["csrf"]
        expect(response.cookies[JWTSessions.access_cookie]).to be_present
      end

      it "creates a new user" do
        expect { subject }.to change(User, :count).by(1)
      end
    end

    context "with invalid params" do
      let(:user_params) do
        {email: "test@email.com", password: "password123", password_confirmation: "password456"}
      end

      it "returns error" do
        subject

        expect(response).not_to be_successful
        expect(json.keys).to eq ["error"]
      end

      it "doesnt create a new user" do
        expect { subject }.not_to change(User, :count)
      end
    end
  end
end
