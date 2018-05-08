# == Schema Information
#
# Table name: lifespan_alterations
#
#  id         :integer          not null, primary key
#  detail_id  :integer
#  extension  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class LifespanAlteration < ApplicationRecord
  belongs_to :detail
  def self.to_csv(make)
    attributes = %w{id detail_id extension created_at updated_at}
    equip = Equipment.all

    CSV.generate(headers: true) do |csv|
      csv << attributes

      LifespanAlteration.each do |e|
        csv << attributes.map{ |attr| e.send(attr) }
      end
    end
  end
end
