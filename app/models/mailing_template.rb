class MailingTemplate < ApplicationRecord
  require 'sidekiq/api'
  include UserSelector
  include AASM


  enum status: {
    draft: 0,
    in_progress: 1,
    finished: 2,
    failed: 3
  }

  paginates_per 20

  validates :game_id, :subject, :text, :planing_start_time_at,  presence: true
  validate :check_filters
  validate :start_time

  serialize :filters
  store_accessor :filters, :payed, :level_from, :level_to

  belongs_to :game
  has_many :mails, class_name: 'MailUser'

  after_save :put_in_queue
  after_destroy :delete_job_from_queue

  aasm column: :status, enum: true do
    state :draft, initial: true
    state :in_progress
    state :finished
    state :failed

    event :start do
      after do
        update(started_at: Time.now)
      end
      transitions from: :draft, to: :in_progress
    end

    event :finish do
      after do
        update(finished_at: Time.now)
      end
      transitions from: :in_progress, to: :finished
    end

    event :fail do
      transitions from: :in_progress, to: :failed
    end

    event :restart do
      transitions from: :failed, to: :in_progress
    end
  end

  def human_status
    status.to_s.humanize
  end

  private

  def check_filters
    return if level_to.to_i == 0
    errors.add(:level_from, 'Have to be smaller than "Level to"') if level_from.to_i > level_to.to_i
  rescue
    return
  end

  def start_time
    return if planing_start_time_at.blank?
    errors.add(:planing_start_time_at, 'You can not run mailing in the past') if planing_start_time_at.beginning_of_minute < Time.now.beginning_of_minute && planing_start_time_at_changed?
  end

  def put_in_queue
    return unless draft?
    delete_job_from_queue
    SendWorker.delay_for(((planing_start_time_at-Time.now)/60).minutes, :retry => false).perform(id)
  end

  def delete_job_from_queue
    queue = Sidekiq::ScheduledSet.new
    queue.each do |job|
      job.delete if /'(.+)'/.match(job.args[0])[1] == 'SendWorker' && /(\d+)/.match(job.args[0])[1].to_i == id
    end
  end
end
