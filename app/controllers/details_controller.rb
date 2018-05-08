require 'time'
class DetailsController < ApplicationController
  before_action :set_detail, only: [:show, :edit, :update, :destroy]

  #-authorize_resource

  # GET /details
  def index
    @detail = Detail.all
  end

  # GET /details/1
  def show
    @detail = Detail.find(params[:id])
    @equipment = @detail.equipment
    @audits = @detail.audits
    @reports = @detail.reports
    # @audits = Audit.where(equipment_id: params[:p_id]).where(detail_id: params[:s_id])
    # @equipment = Equipment.all
  end

  # GET /details/new
  def new
    @is_new = true
    @detail = Detail.new
    @equip = Equipment.find(params[:id])
    @locations = Location.all
  end

  # GET /details/1/edit
  def edit
    @is_new = false
  end

  def toggle_is_archived
    d = Detail.find(params[:id])
    if current_account.admin?
      b = !d.active
      d.update(active: b)
      # d.update(active: not d.active)
    else
      detailRequest = {detail_id: params[:id], archived_new_value: (not d.active)}
      if DetailRequest.where(detail_id: params[:id]).size == 0
        DetailRequest.create(detailRequest)
      end
    end
    Log.create(account_id: current_account[:id], action: "Requested to deactivate detail #{d.equipment.name} : #{d[:id]}")
    redirect_to "/equipment/#{d.equipment_id}", notice: 'Detail was successfully deactivated.'
  end

  # POST /details
  def create

    @detail = Detail.new
    @locations = Location.all
    details = Detail.where(equipment_id: detail_params_new[:equipment_id])

    pars = detail_params_new.to_hash
    pars[:active] = true
    pars[:available] = true
    pars[:life_expectancy] = Equipment.find(detail_params_new[:equipment_id]).expectant_expectancy
    pars[:account_id] = current_account[:id]

    c = pars["count"].to_i
    startID = details.size > 0 ? details.last.detail_id : 0

    a = true
    for i in 1..c do
      pars[:detail_id] = startID + i
      @d = Detail.new(pars)
      if @d.valid?
        @d.save
      else
        a = false
      end
    end


    # ar = (1..c).map{ |a| [params, a] }
    # puts "************88"
    # puts ar
    # puts "************88"
    # ar.map{ |a| a[0][:detail_id] = startID + a[1]}
    # puts "************88"
    # puts ar
    # puts "************88"
    # # arr = (startID..startID+c).map{ |d| params[:detail_id] = d }
    # # puts arr
    # ar.map{ |d| Detail.new(d).save}

    # if @detail.save
    #   Log.create(account_id: current_account[:id], action: "Created #{detail_params_new[:count].to_i} new details for equipment ID #{detail_params_new[:id]}")
    if a
      redirect_to "/equipment/#{detail_params_new[:equipment_id]}", notice: 'Detail was successfully created.'
    end
    # else
    #   render :new
    # end
    # @detail = Detail.new(detail_params_new)
    # @detail[:active] = true
    # @detail[:available] = true
    # @detail[:life_expectancy] = Equipment.find(detail_params_new[:equipment_id]).expectant_expectancy
    # details = Detail.where(equipment_id: @detail.equipment_id)
    # puts "***************"
    # startID = details.size > 0 ? details.last.detail_id : 0
    # c = detail_params_new[:count].to_i
    # for i in 1..c
    #   @detail = Detail.new(detail_params_new)
    #   @detail[:active] = true
    #   @detail[:available] = true
    #   @detail[:life_expectancy] = Equipment.find(detail_params_new[:equipment_id]).expectant_expectancy
    #   @detail[:detail_id] = startID + i
    #   if @detail.save
    #     Log.create(account_id: current_account[:id], action: "Created #{detail_params_new[:count].to_i} new details for equipment ID #{detail_params_new[:id]}")
    #   else
    #     render :new
    #   end
    # end
    # redirect_to "/equipment/#{@detail.equipment_id}", notice: 'Detail was successfully created.'
  end

  # PATCH/PUT /details/1
  def update
    @detail = Detail.find(params[:id])
    puts ("*****111111111111111******")
    puts (detail_params_edit.to_hash)
    # params = detail_update_params.to_hash
    # puts params
    puts ("*****2222222222222222********")
    if @detail.update(detail_params_edit)
      puts ("*****333333333333********")
      redirect_to @detail, notice: 'Detail was successfully updated.'
    else
      render :edit
      puts ("*****OH FUUUUUCK********")
    end
    puts ("*****4444444444444********")
  end

  # DELETE /details/1
  def destroy
    @detail.destroy
    redirect_to "/123", notice: 'Detail was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_detail
      @detail = Detail.find(params[:id])
    end
    # def detail_update_params
    #   params.require(:detail).permit(:location, :equipment_id, :vendor_name, :vendor_contact, :purchase_date, :issue_date, :unit_cost)
    # end
    # Only allow a trusted parameter "white list" through.
    def detail_params_new
      params.require(:detail).permit(:count, :location_id, :equipment_id, :vendor_name, :vendor_contact, :purchase_date, :issue_date, :unit_cost)
    end
    def detail_params_edit
      params.require(:detail).permit(:location_id, :equipment_id, :vendor_name, :vendor_contact, :purchase_date, :issue_date, :unit_cost)
    end
end
