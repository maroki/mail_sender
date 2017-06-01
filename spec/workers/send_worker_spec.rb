require 'rails_helper'

describe SendWorker do
  let(:game) { FactoryGirl.create(:game) }
  let!(:user_01) { FactoryGirl.create(:user, game: game, level: 3) }
  let!(:user_02) { FactoryGirl.create(:user, game: game, level: 5) }
  let!(:user_03) { FactoryGirl.create(:user, game: game, level: 7) }
  let!(:user_04) { FactoryGirl.create(:user, game: game, level: 9) }
  let!(:user_05) { FactoryGirl.create(:user, game: game, level: 11) }

  let!(:mailing_template) { FactoryGirl.create(:mailing_template, level_from: 6, game_id: game.id) }

  subject do
    SendWorker.perform(mailing_template.id)
    mailing_template.reload
  end

  it 'run mailing with filters' do
    subject

    expect(mailing_template.finished?).to eq(true)
    expect(mailing_template.finished_at.present?).to eq(true)
    expect(MailUser.count).to eq(3)
  end
end
