class CreateSessions < ActiveRecord::Migration[5.1]
  def change
    create_table :sessions do |t|
      t.string :session_id
      t.text :data

      t.timestamps
    end
  end
end
