require 'rails_helper'

RSpec.describe MailUser, type: :model do
  describe "MailUser validation" do
    it "has valid factory" do
      mail_user = FactoryGirl.create(:mail_user)
      expect(mail_user).to be_valid
    end
  end
end
