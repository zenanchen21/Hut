# == Schema Information
#
# Table name: accounts
#
#  id                 :integer          not null, primary key
#  username           :string
#  email              :string
#  sign_in_count      :integer          default(0), not null
#  current_sign_in_at :datetime
#  last_sign_in_at    :datetime
#  current_sign_in_ip :inet
#  last_sign_in_ip    :inet
#  uid                :string
#  mail               :string
#  ou                 :string
#  dn                 :string
#  sn                 :string
#  givenname          :string
#  tech               :boolean
#  admin              :boolean
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Account < ApplicationRecord
  include EpiCas::DeviseHelper

  has_many :audits
  has_many :details, through: :audits
  attr_accessor :tier
  has_many :accounts_trainings
  has_many :trainings, through: :accounts_trainings

  def self.system_tech
    tech = where(tech:true).first
    puts "\n\n >>>>>>>> ", tech.attributes, "\n\n"
    tech
  end
  def self.to_csv(make)
    attributes = %w{id username email sign_in_count current_sign_in_at last_sign_in_at current_sign_in_ip last_sign_in_ip uid mail ou dn sn givenname tech admin created_at updated_at}

    CSV.generate(headers: true) do |csv|
      csv << attributes

      Account.all.each do |e|
        csv << attributes.map{ |attr| e.send(attr) }
      end
    end
  end

end
