require 'rails_helper'

RSpec.describe MailingTemplate, type: :model do
  describe "MailingTemplate validation" do
    it "has valid factory" do
      mailing_template = FactoryGirl.create(:mailing_template)
      expect(mailing_template).to be_valid
    end
  end
end
