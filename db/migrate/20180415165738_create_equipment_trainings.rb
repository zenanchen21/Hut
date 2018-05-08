class CreateEquipmentTrainings < ActiveRecord::Migration[5.1]
  def change
    create_table :equipment_trainings do |t|
      t.integer :equipment_id
      t.integer :training_id

      t.timestamps
    end
  end
end
