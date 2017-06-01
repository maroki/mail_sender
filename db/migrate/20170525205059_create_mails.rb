class CreateMails < ActiveRecord::Migration[5.0]
  def change
    create_table :mails do |t|
      t.references :mailing_template
      t.references :user
      t.timestamps
    end
  end
end
