require "rails_helper"

RSpec.describe Users::SignupController, type: :controller do
  describe "POST #create" do
    subject { post :create, params: user_params }
    let(:user_params) { {email: email, password: password, password_confirmation: password_confirmation} }
    let(:email) { "TEst@email.com" }
    let(:password) { "password" }
    let(:password_confirmation) { password }

    context "with valid params" do
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
      context "when passwords aren't equal" do
        let(:password_confirmation) { "4576676" }

        it "returns error" do
          subject

          expect(response).not_to be_successful
          expect(json.keys).to eq ["error"]
          expect(json["error"]).to match %r{Password confirmation has to be equal with password}
        end

        it "doesnt create a new user" do
          expect { subject }.not_to change(User, :count)
        end
      end

      context "when db contains user with the same lowercased email" do
        before { create :user, email: email.downcase }

        it "returns error" do
          subject

          expect(response).not_to be_successful
          expect(json.keys).to eq ["error"]
          expect(json["error"]).to match %r{Email is already taken}
        end

        it "doesnt create a new user" do
          expect { subject }.not_to change(User, :count)
        end
      end
    end
  end
end
