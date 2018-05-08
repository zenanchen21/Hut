# == Schema Information
#
# Table name: logs
#
#  id         :integer          not null, primary key
#  account_id :integer
#  action     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Log < ApplicationRecord
  def self.to_csv(make)
    attributes = %w{id account_id action created_at updated_at}

    CSV.generate(headers: true) do |csv|
      csv << attributes

      Log.all.each do |e|
        csv << attributes.map{ |attr| e.send(attr) }
      end
    end
  end
end
