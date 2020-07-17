require "rails_helper"

RSpec.describe UrlConfig do
  describe "#ensure_scheme_is_valid" do
    subject { described_class.new(params) }

    context "when scheme is invalid" do
      let(:params) { {scheme: "123"} }

      it "has to throw error" do
        expect { subject }.to raise_error(Anyway::Config::ValidationError, "Unknown scheme: 123")
      end
    end
  end
end
