class EquipmentstrainingsController < ApplicationController
  before_action :set_Equipmentstraining, only: [:show, :edit, :update, :destroy]

  # GET /Equipmentstrainings
  def index
    @equipmentstrainings = Equipmentstraining.all
  end

  # GET /Equipmentstrainings/1
  def show
  end

  # GET /Equipmentstrainings/new
  def new
    @equipmentstraining = Equipmentstraining.new
  end

  # POST /Equipmentstrainings
  def create
    @equipmentstraining = Equipmentstraining.new(Equipmentstraining_params)

    if @equipmentsTraining.save
      redirect_to @equipmentsTraining, notice: 'Equipmentstraining was successfully created.'
    else
      render :new
    end
  end

  # DELETE /Equipmentstrainings/1
  def destroy
    @equipmentstraining.destroy
    redirect_to Equipmentstrainings_url, notice: 'Equipmentstraining was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_Equipmentstraining
      @equipmentstraining = Equipmentstraining.find(params[:id])
    end

    def Equipmentstraining_params
      params.require(:Equipmentstraining).permit(:equipment_id, :training_id)
    end
end
