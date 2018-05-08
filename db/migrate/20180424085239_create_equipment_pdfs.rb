class CreateEquipmentPdfs < ActiveRecord::Migration[5.1]
  def change
    create_table :equipment_pdfs do |t|
      t.integer :equipment_id
      t.integer :pdf_id

      t.timestamps
    end
  end
end
