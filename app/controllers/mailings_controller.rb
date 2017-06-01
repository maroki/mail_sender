class MailingsController < ApplicationController
  before_action :fetch_mailing_template, except: [:index, :new, :create]
  before_action :enable_editing?, only: [:edit, :update, :destroy]

  def index
    @mailing_templates = MailingTemplate.order(id: :desc).includes(:game).page params[:page]
  end

  def new
    @mailing_template = MailingTemplate.new
  end

  def create
    @mailing_template = MailingTemplate.new(mailing_template_params)
    if @mailing_template.save
      redirect_to mailings_path, notice: 'Created new Mailing Template'
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @mailing_template.update(mailing_template_params)
      redirect_to mailings_path, notice: 'Mailing Template updated'
    else
      render 'edit'
    end
  end

  def destroy
    @mailing_template.destroy
    redirect_to mailings_path
  end

  private

  def mailing_template_params
    params.require(:mailing_template).permit(:game_id, :subject, :text, :planing_start_time_at, :payed, :level_from, :level_to)
  end

  def fetch_mailing_template
    @mailing_template = MailingTemplate.find(params[:id])
  rescue
    not_found!
  end

  def enable_editing?
    redirect_to mailings_path and return unless @mailing_template.draft?
  end
end
