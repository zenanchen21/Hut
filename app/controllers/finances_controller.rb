require 'chartkick'
require 'date'
require 'time'

class FinancesController < ApplicationController

  #authorize_resource

  def index
    if !current_account.admin?
      redirect_to "/"
    end
    @equipment = Equipment.order(:id).all
    @detail = Detail.where(available: true).where(active: true)
    @data = {}

    if params[:s_id]
      details = Detail.where(equipment_id: params[:p_id]).where(detail_id: params[:s_id])
      detail = details.first
      reports = detail.reports

      # Info
      @data["detail"] = detail

      # Depreciation
      @data["depreciation"] = calcDepreciationValues(details, Date.today.next_year(-1), Date.today.next_year(1), "MONTHLY")

      # Life progress
      @data["life_progress"] = progress_life detail

      # Usage count
      audits = detail.audits


    elsif params[:p_id]
      equipment = Equipment.find(params[:p_id])
      details = equipment.detail
      report_id = details.map { |d| d.reports.pluck(:id) }.flatten
      reports = Report.where(id: report_id)

      # Info
      @data["equipment"] = equipment
      @totsAvailable = details.where(available: true).size
      @total = details.size

      # Depreciation
      @data["depreciation"] = calcDepreciationValues(details, Date.today.next_year(-1), Date.today.next_year(1), "MONTHLY")

      # Usage count
      audits_id = []
      details.each { |d| audits_id.concat d.audits.pluck(:id)}
      audits = Audit.where(id: audits_id)

      #Upcoming Expiries
      @data["upc_exp_tableB"] = upcoming_exp (Equipment.where(id: params[:p_id]))

    else
      details = Detail.all
      reports = Report.all

      # Upcoming Expiries
      # where is_exp returns true, return array of details
      # for single items, displays expiry date
      @data["upc_exp_tableA"] = upcoming_exp (Equipment.all)

      # Usage count
      audits = Audit.all

    end
    @data["tot_val"] = total_val (details)
    @data["usage_count"] = calcUsageValues(audits, Date.today.next_year(-1), Date.today, "MONTHLY")
    @data["report_rate"] = calc_report_values(reports, Date.today.next_year(-1), Date.today, "MONTHLY")

  end


  # POST /equipment/search
  def search
    # {"search" => {"name" => "some entered name"} }
    @equipment = Equipment.where("lower (name) LIKE :query", query: "%#{params[:search][:name].downcase}%").or(Equipment.where(id: params[:search][:name]))
    @detail = Detail.none
    @searched = true
    render :index
  end


  # Universal


  # Total value and current value
  # Total value
  def total_val (details)@s
    total_val = 0
    return details.each { |d| total_val += d.unit_cost }
  end

  # Depreciation formula
  def calcDepreciationValues(details, startDate, endDate, interval)

    depreciation_values = []

    details.each{ |d|
      hash = {}
      calcDates(startDate, endDate, interval).each { |date|
        hash[date] = calcDepreciation(d.unit_cost, d.created_at, d.life_expectancy, date)
      }
      depreciation_values.push({name: d.detail_id, data: hash })
    }

    return depreciation_values
  end

  def calcDepreciation(startPrice, startDate, expectancy, date)
    value = startPrice * (1 - ((date.to_time - startDate.to_time) / (31557600.0 / 12) / expectancy)).round(2)
    return (value > startPrice or value < 0) ? [] : value
  end

  # Usage rate
  def calcUsageValues(audits, startDate, endDate, interval)
    usage_rates = {}
    arr = calcDates(startDate, endDate, interval)
    for t in 0.. (arr.length - 2) do
      usage_rates[arr[t]] = usage(audits, arr[t], arr[t+1])
    end
    return usage_rates
  end
  def usage(audits, dateTime1, dateTime2)
    use_time = 0
    audits.where("created_at < ?", dateTime2).where("end_time > ?", dateTime1).find_each do |u|
      use_time += ([dateTime2, u.end_time].min).to_time.to_i - ([dateTime1, u.created_at].max).to_time.to_i
    end
    return use_time
  end

  # Failure rate
  def calc_report_values(reports, startDate, endDate, interval)
    rep_rates = {}
    arr = calcDates(startDate, endDate, interval)
    for t in 0.. (arr.length - 2) do
      rep_rates[arr[t]] = report_rate(reports, arr[t], arr[t+1])
    end
    return rep_rates
  end
  def report_rate(reports, dateTime1, dateTime2)
    return reports.where(:created_at => dateTime1..dateTime2).size
  end



  # General and Product


  # Upcoming Expiries
  def upcoming_exp equipments
    arr = []
    equipments.where(consumable: false).map{ |e| arr.concat e.detail.select{ |d| d.is_expired(3) }  }
    return arr
  end


  # Product and Serial


  # Equipment details
  # To be done in HAML file

  # Serial


  # Life timeline
  # Bootstrap progress bar - set progress to be (expiry date-date created).to_i / 100
  def progress_life detail
    return ((Date.today.to_time.to_f - detail.issue_date.to_time.to_f) / (detail.expire_date.to_time.to_f - detail.issue_date.to_time.to_f) * 100).round
  end

  # Vendor Info
  # to be done in HAML file


  # Calculate dates
  def calcDates (startDate, endDate, interval)
    arr = []
    while (startDate < endDate) do
      arr.push(startDate)
      case interval
      when "DAILY"
        startDate = startDate.next_day
      when "WEEKLY"
        startDate = startDate.next_day(7)
      when "MONTHLY"
        startDate = startDate.next_month
      else
        startDate = startDate.next_year
      end
    end
    arr.push(endDate)
    return arr
  end
end
