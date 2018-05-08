class CreateLifespanAlteration < ActiveRecord::Migration[5.1]
  def change
    create_table :lifespan_alterations do |t|
      t.integer :detail_id
      t.integer :extension

      t.timestamps
    end
  end
end
