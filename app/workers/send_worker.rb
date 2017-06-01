class SendWorker
  include Sidekiq::Worker

  class << self

    def perform(mailing_template_id)
      template = MailingTemplate.draft.find_by_id(mailing_template_id)
      return unless template.present? || template.draft?
      template.start!

      begin
        template.users_to_send.find_each do |user|
          CustomMailer.compose(template, user).deliver_now
          template.mails.create(user: user)
        end
      rescue
        template.fail!
      end

      template.finish!

    end
  end

end
