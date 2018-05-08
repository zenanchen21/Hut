# == Schema Information
#
# Table name: locations
#
#  id                :integer          not null, primary key
#  name              :string
#  description       :text
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  avatar            :string
#  avatar_file_cache :string
#

class Location < ApplicationRecord
  mount_uploader :avatar, LocationsImageUploader
  has_many :detail
  validates :name, :presence => true
  validates :info, :presence => true
  
  def self.to_csv(make)
    attributes = %w{id name description created_at updated_at avatar avatar_file_cache}

    CSV.generate(headers: true) do |csv|
      csv << attributes

      Location.all.each do |e|
        csv << attributes.map{ |attr| e.send(attr) }
      end
    end
  end
end
