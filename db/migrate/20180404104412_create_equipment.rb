class CreateEquipment < ActiveRecord::Migration[5.1]
  def change
    create_table :equipment do |t|
      t.string :name
      t.text :description
      t.integer :expectant_expectancy
      t.boolean :consumable
      t.string :avatar
      t.string :avatar_file_cache
      t.boolean :approved

      t.timestamps
    end
  end
end
