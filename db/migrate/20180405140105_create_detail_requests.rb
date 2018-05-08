class CreateDetailRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :detail_requests do |t|
      t.integer :detail_id
      t.boolean :archived_new_value
      
      t.timestamps
    end
  end
end
