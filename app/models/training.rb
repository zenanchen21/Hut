# == Schema Information
#
# Table name: trainings
#
#  id          :integer          not null, primary key
#  name        :string
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Training < ApplicationRecord
  has_many :accounts_trainings
  has_many :equipment_trainings
  has_many :accounts, through: :accounts_trainings
  has_many :equipment, through: :equipment_trainings
  validates :name, :presence => true
  validates :description, :presence => true
  
  def self.to_csv(make)
    attributes = %w{id name description created_at updated_at}

    CSV.generate(headers: true) do |csv|
      csv << attributes

      Training.all.each do |e|
        csv << attributes.map{ |attr| e.send(attr) }
      end
    end
  end
end
