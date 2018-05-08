class TrainingsController < ApplicationController
  before_action :set_training, only: [:show, :edit, :update, :destroy]

  # GET /trainings
  def index
    @trainings = Training.all
  end

  # GET /trainings/1
  def show
  end

  # GET /trainings/new
  def new
    @training = Training.new
  end

  def remove_account
    puts "1"
    account_training = AccountsTraining.find(params[:id])
    Log.create(account_id: current_account[:id], action: "Removed #{account_training.training.name} from account ID: #{account_training.account_id}")
    puts "2"
    AccountsTraining.destroy(params[:id])
    puts "3"
    redirect_to "/accounts/#{account_training.account_id}", notice: 'Training was successfully removed.'
  end

  def remove_equipment
    puts "1"
    equipment_training = EquipmentTraining.find(params[:id])
    Log.create(account_id: current_account[:id], action: "Removed #{equipment_training.training.name} from equipment ID: #{equipment_training.equipment_id}")
    puts "2"
    EquipmentTraining.destroy(params[:id])
    puts "3"
    redirect_to "/equipment/#{equipment_training.equipment_id}", notice: 'Training was successfully removed.'
  end

  def add_equipment
    if params[:t_id]
      Log.create(account_id: current_account[:id], action: "Added #{Training.find(params[:t_id]).name} training to equipment: #{Equipment.find(params[:p_id]).name}")
      EquipmentTraining.create(equipment_id: params[:p_id], training_id: params[:t_id])
      redirect_to "/equipment/#{params[:p_id]}", notice: 'Training was successfully created.'
    else
      @trainings = Training.all - Equipment.find(params[:p_id]).trainings
    end
  end

  def add_account
    if params[:t_id]
      Log.create(account_id: current_account[:id], action: "Added #{Training.find(params[:t_id]).name} training to account ID: #{params[:a_id]}")
      AccountsTraining.create(account_id: params[:a_id], training_id: params[:t_id])
      redirect_to "/accounts/#{params[:a_id]}", notice: 'Training was successfully created.'
    else
      @trainings = Training.all - Account.find(params[:a_id]).trainings
    end
  end

  # GET /trainings/1/edit
  def edit
  end

  # POST /trainings
  def create
    @training = Training.new(training_params)

    if @training.save
      redirect_to @training, notice: 'Training was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /trainings/1
  def update
    if @training.update(training_params)
      redirect_to @training, notice: 'Training was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /trainings/1
  def destroy
    @training.destroy
    redirect_to trainings_url, notice: 'Training was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_training
      @training = Training.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def training_params
      params.require(:training).permit(:name, :description)
    end
end
