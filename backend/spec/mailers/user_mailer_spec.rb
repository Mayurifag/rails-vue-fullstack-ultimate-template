require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  let(:user) { build :user }
  let(:mail) { subject.deliver_now }

  describe "#reset_password" do
    subject { described_class.reset_password(user) }

    it "renders the receiver email" do
      expect(mail.to).to eq([user.email])
    end
  end
end
