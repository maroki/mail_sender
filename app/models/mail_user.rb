class MailUser < ApplicationRecord
  self.table_name = 'mails'
  belongs_to :mailing_template
  belongs_to :user
end
