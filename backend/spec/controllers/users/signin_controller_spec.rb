require "rails_helper"

RSpec.describe Users::SigninController, type: :controller do
  let(:user) { create(:user) }

  describe "POST #create" do
    subject { post :create, params: user_params }

    context "with valid params" do
      let(:user_params) { {email: user.email, password: "password"} }

      it "returns http success" do
        subject

        expect(response).to be_successful
        expect(json.keys).to eq ["csrf"]
        expect(response.cookies[JWTSessions.access_cookie]).to be_present
      end
    end

    context "with invalid params" do
      let(:user_params) { {email: user.email, password: "incorrect"} }

      it "returns unauthorized for invalid params" do
        subject
        expect(response).to have_http_status(401)
      end
    end
  end

  describe "DELETE #destroy logout" do
    subject { delete :destroy }

    context "without authorization" do
      it "returns unauthorized http status" do
        subject

        expect(response).to have_http_status(401)
      end
    end

    context "with valid authorization" do
      it "returns http success with valid tokens" do
        payload = {user_id: user.id, aud: [user.role]}
        session = JWTSessions::Session.new(
          payload: payload,
          refresh_by_access_allowed: true,
          namespace: "user_#{user.id}"
        )
        tokens = session.login
        request.cookies[JWTSessions.access_cookie] = tokens[:access]
        request.headers[JWTSessions.csrf_header] = tokens[:csrf]

        subject

        expect(response).to have_http_status(200)
      end
    end
  end
end
