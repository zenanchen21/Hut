class CreateServiceReminder < ActiveRecord::Migration[5.1]
  def change
    create_table :service_reminders do |t|
      t.integer :detail_id
      t.boolean :is_serviced

      t.timestamps
    end
  end
end
