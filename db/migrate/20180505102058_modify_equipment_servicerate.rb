class ModifyEquipmentServicerate < ActiveRecord::Migration[5.1]
  def change
    change_table :equipment do |t|
      t.integer :service_rate
    end
  end
end
