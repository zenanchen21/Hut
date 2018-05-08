# == Schema Information
#
# Table name: equipment_pdfs
#
#  id           :integer          not null, primary key
#  equipment_id :integer
#  pdf_id       :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class EquipmentPdf < ApplicationRecord
  belongs_to :equipment
  belongs_to :pdf
  def self.to_csv(make)
    attributes = %w{id equipment_id pdf_id created_at updated_at}

    CSV.generate(headers: true) do |csv|
      csv << attributes

      EquipmentPdf.all.each do |e|
        csv << attributes.map{ |attr| e.send(attr) }
      end
    end
  end
end
