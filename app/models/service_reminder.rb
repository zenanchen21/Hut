# == Schema Information
#
# Table name: service_reminders
#
#  id          :integer          not null, primary key
#  detail_id   :integer
#  is_serviced :boolean
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  description :text
#

class ServiceReminder < ApplicationRecord
  belongs_to :detail
  def self.to_csv(make)
    attributes = %w{id detail_id is_serviced created_at updated_at description}
    equip = Equipment.all

    CSV.generate(headers: true) do |csv|
      csv << attributes

      ServiceReminder.all.each do |e|
        csv << attributes.map{ |attr| e.send(attr) }
      end
    end
  end
end
