class CreateAccountsTrainings < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts_trainings do |t|
      t.integer :account_id
      t.integer :training_id

      t.timestamps
    end
  end
end
