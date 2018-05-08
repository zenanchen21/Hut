class ModifyServiceReminder < ActiveRecord::Migration[5.1]
  def change
    change_table :service_reminders do |t|
      t.text :description
    end
  end
end
