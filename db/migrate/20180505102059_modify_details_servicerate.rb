class ModifyDetailsServicerate < ActiveRecord::Migration[5.1]
  def change
    change_table :details do |t|
      t.date :service_date
    end
  end
end
