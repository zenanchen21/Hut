class CreateAudits < ActiveRecord::Migration[5.1]
  def change
    create_table :audits do |t|
      t.integer :account_id
      t.integer :detail_id
      t.string :description

      t.datetime :end_time
      t.timestamps
    end
  end
end
