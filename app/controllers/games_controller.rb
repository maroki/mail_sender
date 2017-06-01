class GamesController < ApplicationController
  before_action :fetch_game, except: [:index, :new, :create]

  def index
    @games = Game.order(id: :desc).page params[:page]
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)
    if @game.save
      redirect_to games_path, notice: 'Created new game'
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @game.update(game_params)
      redirect_to games_path, notice: 'Game updated'
    else
      render 'edit'
    end
  end

  def destroy
    @game.destroy
    redirect_to games_path
  end

  private

  def game_params
    params.require(:game).permit(:name, :send_from)
  end

  def fetch_game
    @game = Game.find(params[:id])
  rescue
    not_found!
  end
end
