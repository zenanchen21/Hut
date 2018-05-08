# == Schema Information
#
# Table name: pdfs
#
#  id             :integer          not null, primary key
#  pdf            :string
#  pdf_type_id    :integer
#  name           :string
#  description    :string
#  pdf_file_cache :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Pdf < ApplicationRecord
  mount_uploader :pdf, CategoryPdfUploader
  belongs_to :pdf_type
  validates :name, :presence => true
  validates :description, :presence => true
  validates :pdf, :presence => true
  
  def self.to_csv(make)
    attributes = %w{id pdf pdf_type_id name description pdf_file_cache created_at updated_at}

    CSV.generate(headers: true) do |csv|
      csv << attributes

      Pdf.all.each do |e|
        csv << attributes.map{ |attr| e.send(attr) }
      end
    end
  end
  # validates :name, :presence => true
  # validates :description, :presence => true
end
