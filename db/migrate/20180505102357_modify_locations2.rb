class ModifyLocations2 < ActiveRecord::Migration[5.1]
  def change
    change_table :locations do |t|
      t.rename :info, :description
    end
  end
end
