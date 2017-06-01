require 'rails_helper'

RSpec.describe Game, type: :model do
  describe "Game validation" do
    it "has valid factory" do
      game = FactoryGirl.create(:game)
      expect(game).to be_valid
    end
  end
end
