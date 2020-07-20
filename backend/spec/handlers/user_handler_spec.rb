require "rails_helper"

RSpec.describe UserHandler, type: :handler do
  let(:user) { build :user, reset_password_token: reset_password_token }

  describe "#generate_password_token!" do
    subject { described_class.new(user).generate_password_token! }

    let(:reset_password_token) { nil }

    it "has to change reset_password_token from nil to something" do
      subject
      expect(user.reset_password_token).not_to be nil
    end
  end

  describe "#clear_password_token!" do
    subject { described_class.new(user).clear_password_token! }

    let(:reset_password_token) { "something_url_random" }

    it "has to change reset_password_token from something to nil" do
      subject
      expect(user.reset_password_token).to be nil
    end
  end
end
