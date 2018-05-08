class CreateDetails < ActiveRecord::Migration[5.1]
  def change
    create_table :details do |t|
      t.integer :equipment_id
      t.integer :detail_id
      t.text :location
      t.string :vendor_name
      t.string :vendor_contact
      t.date :purchase_date
      t.float :unit_cost
      t.integer :life_expectancy
      t.boolean :active
      t.boolean :available
      t.date :issue_date

      t.timestamps
    end
  end
end
