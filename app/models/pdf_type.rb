# == Schema Information
#
# Table name: pdf_types
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PdfType < ApplicationRecord
  validates :name, :presence => true
  
  def self.to_csv(make)
    attributes = %w{id name created_at updated_at}

    CSV.generate(headers: true) do |csv|
      csv << attributes

      PdfType.all.each do |e|
        csv << attributes.map{ |attr| e.send(attr) }
      end
    end
  end
end
