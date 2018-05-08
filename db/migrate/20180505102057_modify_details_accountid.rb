class ModifyDetailsAccountid < ActiveRecord::Migration[5.1]
  def change
    change_table :details do |t|
      t.integer :account_id
    end
  end
end
