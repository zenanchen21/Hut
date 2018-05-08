# == Schema Information
#
# Table name: details
#
#  id              :integer          not null, primary key
#  equipment_id    :integer
#  detail_id       :integer
#  vendor_name     :string
#  vendor_contact  :string
#  purchase_date   :date
#  unit_cost       :float
#  life_expectancy :integer
#  active          :boolean
#  available       :boolean
#  issue_date      :date
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  location_id     :integer
#  account_id      :integer
#  service_date    :date
#

class Detail < ApplicationRecord
  belongs_to :equipment
  has_many :audits
  has_many :reports, through: :audits
  has_many :accounts, through: :audits
  belongs_to :location
  belongs_to :owner, class_name: 'Account', foreign_key: 'account_id'
  attr_accessor :count

  # validates_presence_of :location_id
  # validates :vendor_name, :presence => true
  # validates :vendor_contact, :presence => true
  # validates :unit_cost, :numericality => { greater_than: 0}

  def expire_date
    return self.issue_date.to_date.next_month(self.life_expectancy)
  end

  def is_expired (m)
    return self.expire_date < Date.today.next_month(m)
  end

  def self.to_csv(make)
    attributes = %w{id equipment_id detail_id vendor_name vendor_contact purchase_date unit_cost life_expectancy active available issue_date created_at update_at location_id account_id service_date}

    CSV.generate(headers: true) do |csv|
      csv << attributes

      Detail.all.each do |e|
        csv << attributes.map{ |attr| e.send(attr) }
      end
    end
  end
  def service
    # Send email
    self.update(service_date: self.service_date.next_month(self.equipment.service_rate))
    ServiceReminder.create(detail_id: self[:id], is_serviced: false, description: "")
  end
end
