require "rails_helper"

RSpec.describe Users::UsersController, type: :controller do
  describe "GET #whoami" do
    let(:user) { create(:user) }
    before { sign_in_as(user) }

    subject { get :whoami }

    it "returns a success response" do
      subject

      expect(response).to be_successful
      expect(json["email"]).to eq user.email
    end
  end
end
