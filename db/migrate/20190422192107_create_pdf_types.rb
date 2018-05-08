class CreatePdfTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :pdf_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
