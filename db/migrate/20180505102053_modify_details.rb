class ModifyDetails < ActiveRecord::Migration[5.1]
  def change
    change_table :details do |t|
      t.rename :location, :location_id
    end
  end
end
