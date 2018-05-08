require 'time'

class EquipmentController < ApplicationController
  before_action :set_equipment, only: [:show, :edit, :update, :destroy, :add]

#-  authorize_resource

  # GET /equipment
  def index
    @equipment = Equipment.order(:id).where(approved: true)
    @detail = Detail.where(available: true).where(active: true).where(approved: false)
    updateAvailabilities
  end

  def updateAvailabilities
    Detail.where(available: false).where(active: true).each do |detail|
      if !detail.equipment.consumable and detail.audits.size > 0
        if detail.audits.last.end_time < Time.now
            detail.update(:available => true)
          end
      end
    end
  end

  # GET /equipment/1
  def show
    updateAvailabilities
    @equipment = Equipment.find(params[:id])

    @equipmentAvailable = @equipment.detail.where(available: true).where(active: true)
    @equipmentUnavailable = @equipment.detail.where(available: false).where(active: true)

    @inactive = @equipment.detail.where(active: false)

    @equipmentActive = @equipment.detail.where(active: true)
  end

  # GET /equipment/new
  def new
    @equipment = Equipment.new
  end

  # # GET /equipment/backup
  # def backup for the button 
  # end

  def add

  end

  def deactivate_all
    @equipment = Equipment.find(params[:id])
    @equipmentActive = @equipment.detail.where(active: true)
    @equipmentActive.each do |equip|
      equip.update(active: false)
    end
    redirect_to "/equipment/#{@equipment.id}", notice: 'All details have been successfully deactivated.'
  end

  def activate_all
    @equipment = Equipment.find(params[:id])
    @equipmentActive = @equipment.detail.where(active: false)
    @equipmentActive.each do |equip|
      equip.update(active: true)
    end
    redirect_to "/equipment/#{@equipment.id}", notice: 'All details have been successfully deactivated.'
  end

  # GET /equipment/1/edit
  def edit
  end

  # POST /equipment
  def create
    @equipment = Equipment.new(equipment_params)

    @equipment[:approved] = false
    if current_account.admin?
      @equipment[:approved] = true
    end

    if @equipment.save
      Log.create(account_id: current_account[:id], action: "Created a new piece of equipment with ID: #{Equipment.all.last.id} and name: #{Equipment.all.last.name} on #{Equipment.all.last.created_at}")
      redirect_to "/equipment/#{Equipment.all.last.id}", notice: 'Equipment was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /equipment/1
  def update
    if @equipment.update(equipment_params)
      redirect_to @equipment, notice: 'Equipment was successfully updated.'
    else
      render :edit
    end
  end

  # POST /equipment/search
  def search
    updateAvailabilities
    # {"search" => {"name" => "some entered name"} }
    locationIDs = Location.where(name: params[:search][:name]).pluck(:id)
    equipmentIDs = Detail.where(:location_id => locationIDs).map{ |d| d.equipment_id}.flatten
    @equipment = Equipment.where("lower (name) LIKE :query", query: "%#{params[:search][:name].downcase}%").or(Equipment.where(id: params[:search][:name])).or(Equipment.where(:id => equipmentIDs))

    @detail = Detail.all
    @searched = true
    render :index
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_equipment
      @equipment = Equipment.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def equipment_params
      params.require(:equipment).permit(:name, :consumable, :description, :avatar, :expectant_expectancy, :avatar_file_cache)
    end
end
