module AuthHelper
  def sign_in_as(user)
    payload = {user_id: user.id, aud: [user.role]}
    session = JWTSessions::Session.new(payload: payload, refresh_by_access_allowed: true, namespace: "user_#{user.id}")
    tokens = session.login
    request.cookies[JWTSessions.access_cookie] = tokens[:access]
    request.headers[JWTSessions.csrf_header] = tokens[:csrf]
  end
end
