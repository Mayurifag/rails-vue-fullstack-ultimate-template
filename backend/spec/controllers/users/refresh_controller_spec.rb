require "rails_helper"

RSpec.describe Users::RefreshController, type: :controller do
  let(:access_cookie) { @tokens[:access] }
  let(:csrf_token) { @tokens[:csrf] }
  let(:user) { create(:user) }

  describe "POST #create" do
    subject { post :create }

    context "with valid params" do
      before do
        # set expiration time to 0 to create an already expired access token
        JWTSessions.access_exp_time = 0
        payload = {user_id: user.id, aud: [user.role]}
        session = JWTSessions::Session.new(
          payload: payload,
          refresh_by_access_allowed: true,
          namespace: "user_#{user.id}"
        )
        @tokens = session.login
        JWTSessions.access_exp_time = 3600
      end

      it "has to be successfull" do
        request.cookies[JWTSessions.access_cookie] = access_cookie
        request.headers[JWTSessions.csrf_header] = csrf_token

        subject

        expect(response).to be_successful
        expect(json.keys).to eq ["csrf"]
        expect(response.cookies[JWTSessions.access_cookie]).to be_present
      end
    end

    context "with not expired token" do
      before do
        payload = {user_id: user.id}
        session = JWTSessions::Session.new(
          payload: payload,
          refresh_by_access_allowed: true,
          namespace: "user_#{user.id}"
        )
        @tokens = session.login
      end

      it "has not to be successful" do
        request.cookies[JWTSessions.access_cookie] = access_cookie
        request.headers[JWTSessions.csrf_header] = csrf_token

        subject

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
