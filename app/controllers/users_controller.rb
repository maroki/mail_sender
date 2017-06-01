class UsersController < ApplicationController
  before_action :fetch_user, except: [:index, :new, :create]

  def index
    @users = User.order(id: :desc).includes(:game).page params[:page]
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path, notice: 'Created new user'
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to users_path, notice: 'User updated'
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :level, :payed, :last_visit_at, :game_id)
  end

  def fetch_user
    @user = User.find(params[:id])
  rescue
    not_found!
  end
end
