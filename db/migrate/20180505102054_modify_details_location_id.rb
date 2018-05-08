class ModifyDetailsLocationId < ActiveRecord::Migration[5.1]
  def change
    change_table :details do |t|
      t.remove :location_id
      t.integer :location_id
    end
  end
end
