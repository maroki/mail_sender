require 'rails_helper'

RSpec.describe User, type: :model do
  describe "User validation" do
    it "has valid factory" do
      user = FactoryGirl.create(:user)
      expect(user).to be_valid
    end
  end
end
