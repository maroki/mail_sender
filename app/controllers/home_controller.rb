class HomeController < ApplicationController
  def index
    @games = Game.count
    @users = User.count
    @mailings = MailingTemplate.count
  end
end
