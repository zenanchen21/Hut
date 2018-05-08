# == Schema Information
#
# Table name: reports
#
#  id          :integer          not null, primary key
#  audit_id    :integer
#  description :text
#  fixing_logs :text
#  resolved_by :text
#  urgency     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Report < ActiveRecord::Base
  belongs_to :audit
  attr_accessor :extend_lifetime
  attr_accessor :request_deactivation
  def self.to_csv(make)
    attributes = %w{id audit_id description fixing_logs resolved_by urgency created_at updated_at}

    CSV.generate(headers: true) do |csv|
      csv << attributes

      Report.all.each do |e|
        csv << attributes.map{ |attr| e.send(attr) }
      end
    end
  end
  # validates :fixing_logs, :presence => true
  # validates :extend_lifetime, :numericality => true
end
