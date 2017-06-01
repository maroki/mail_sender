module UserSelector
  extend ActiveSupport::Concern

  def users_to_send
    result = game.users
    result = result.where('level >= ?', level_from) if level_from.present?
    result = result.where('level <= ?', level_to) if level_to.present?
    result = result.where('payed = ?', payed) if payed.present?
    result
  end
end
