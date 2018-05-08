class CreateLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :logs do |t|
      t.integer :account_id
      t.string :action

      t.timestamps
    end
  end
end
