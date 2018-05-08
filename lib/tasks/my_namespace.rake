require 'time'

namespace :my_namespace do
  desc "TODO"
  task check_service_dates: :environment do
    details = Detail.where("service_date <= ?", Time.now)
    puts details
    details.map{ |d| d.service }

    # ZENAN SEND EMAIL PLS
    #
    # SEND TO: detail.owner.email
    # CONTENTS: details
    #
    # FROM: ZENAN

  end
end
