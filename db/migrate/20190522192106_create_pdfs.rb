class CreatePdfs < ActiveRecord::Migration[5.1]
  def change
    create_table :pdfs do |t|
      t.string :pdf
      t.integer :pdf_type_id
      t.string :name
      t.string :description
      t.string :pdf_file_cache
      t.timestamps
    end
  end
end
