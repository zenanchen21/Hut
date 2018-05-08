# == Schema Information
#
# Table name: equipment_trainings
#
#  id           :integer          not null, primary key
#  equipment_id :integer
#  training_id  :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class EquipmentTraining < ApplicationRecord
  belongs_to :equipment
  belongs_to :training
  def self.to_csv(make)
    attributes = %w{id equipment_id training_id created_at updated_at}

    CSV.generate(headers: true) do |csv|
      csv << attributes

      EquipmentTraining.all.each do |e|
        csv << attributes.map{ |attr| e.send(attr) }
      end
    end
  end
end
