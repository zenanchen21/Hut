# == Schema Information
#
# Table name: audits
#
#  id          :integer          not null, primary key
#  account_id  :integer
#  detail_id   :integer
#  description :string
#  end_time    :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Audit < ApplicationRecord
  belongs_to :detail
  has_one :equipment, through: :detail
  belongs_to :account
  has_one :report

  # validates :description, :presence => true, :length => { :minimum => 10 }
  # validate :end_time_cannot_be_in_the_past
  # def end_time_cannot_be_in_the_past
  #   if end_date.present? && end_date.to_date < Date.today
  #     errors.add(:end_date, " Has to be in the future")
  #   end
  # end
  def self.to_csv(make)
    attributes = %w{id account_id detail_id description end_time created_at updated_at}

    CSV.generate(headers: true) do |csv|
      csv << attributes

      Audit.all.each do |e|
        csv << attributes.map{ |attr| e.send(attr) }
      end
    end
  end
end
