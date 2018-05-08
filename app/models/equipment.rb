# == Schema Information
#
# Table name: equipment
#
#  id                   :integer          not null, primary key
#  name                 :string
#  description          :text
#  expectant_expectancy :integer
#  consumable           :boolean
#  avatar               :string
#  approved             :boolean
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  avatar_file_cache    :text
#  service_rate         :integer
#
require 'csv'

class Equipment < ApplicationRecord
  mount_uploader :avatar, EquipmentImageUploader

  has_many :equipment_trainings
  has_many :trainings, through: :equipment_trainings

  has_many :detail

  has_many :equipment_pdfs
  has_many :pdfs, through: :equipment_pdfs
  def self.to_csv(message)
    puts message
    attributes = %w{id name description expectant_expectancy consumable avatar approved created_at updated_at avatar_file_cache service_rate}
    equip = Equipment.all

    CSV.generate(headers: true) do |csv|
      csv << attributes

      equip.each do |e|
        csv << attributes.map{ |attr| e.send(attr) }
      end
    end
  end

  # validates :name, :presence => true
  # validates :expectant_expectancy, :numericality => { greater_than: 0}, if: -> { not consumable }
  # validates :description, :presence => true, :length => { :minimum => 10 }

end
