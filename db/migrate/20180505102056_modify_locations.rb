class ModifyLocations < ActiveRecord::Migration[5.1]
  def change
    change_table :locations do |t|
      t.string :avatar
      t.string :avatar_file_cache
    end
  end
end
