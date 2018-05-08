# == Schema Information
#
# Table name: accounts_trainings
#
#  id          :integer          not null, primary key
#  account_id  :integer
#  training_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class AccountsTraining < ApplicationRecord
  belongs_to :account
  belongs_to :training
  def self.to_csv(make)
    attributes = %w{id account_id training_id created_at updated_at}

    CSV.generate(headers: true) do |csv|
      csv << attributes

      AccountsTraining.all.each do |e|
        csv << attributes.map{ |attr| e.send(attr) }
      end
    end
  end
end
