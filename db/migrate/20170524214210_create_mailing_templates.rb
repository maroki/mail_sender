class CreateMailingTemplates < ActiveRecord::Migration[5.0]
  def change
    create_table :mailing_templates do |t|
      t.references :game, index: true
      t.string :subject
      t.string :text
      t.integer :status, null: false, default: 0
      t.datetime :planing_start_time_at
      t.datetime :started_at
      t.datetime :finished_at
      t.json :filters, null: false, default: '{}'
      t.timestamps
    end
  end
end
