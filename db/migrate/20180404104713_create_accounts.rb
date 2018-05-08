class CreateAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts do |t|
      t.string :username
      t.string :email
      t.integer :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.inet :current_sign_in_ip
      t.inet :last_sign_in_ip
      t.string :uid
      t.string :mail
      t.string :ou
      t.string :dn
      t.string :sn
      t.string :givenname
      t.boolean :tech
      t.boolean :admin

      t.timestamps
    end
  end
end
