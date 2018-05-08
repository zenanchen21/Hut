class CreateReports < ActiveRecord::Migration[5.1]
  def change
    create_table :reports do |t|
      t.integer :audit_id
      t.text :description
      t.text :fixing_logs
      t.text :resolved_by
      t.integer :urgency

      t.timestamps
    end
  end
end
