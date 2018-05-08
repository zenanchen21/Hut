# == Schema Information
#
# Table name: detail_requests
#
#  id                 :integer          not null, primary key
#  detail_id          :integer
#  archived_new_value :boolean
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class DetailRequest < ApplicationRecord
  def self.to_csv(make)
    attributes = %w{id detail_id archived_new_value created_at updated_at}

    CSV.generate(headers: true) do |csv|
      csv << attributes

      DetailRequests.all.each do |e|
        csv << attributes.map{ |attr| e.send(attr) }
      end
    end
  end
end
