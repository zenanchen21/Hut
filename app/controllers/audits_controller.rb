class AuditsController < ApplicationController
  before_action :set_account, only: [:show, :edit, :update, :destroy]

  authorize_resource

  # GET /products
  def index
    @audits = Audit.all
  end

  # GET /products/1
  def show
    @audit = Audit.find(params[:id])
  end

  # GET /products/new
  def new
    @audit = Audit.new
    @detail = Detail.find(params[:s_id])
    @equipment = @detail.equipment
    # # if @equipment.consumable
    # #   @detail.active = false
    # end
  end

  # POST /products
  def create
    if Detail.find(audit_params[:detail_id]).equipment.approved
      Detail.find(audit_params[:detail_id]).update(available: false)
      audit_params[:account_id] = current_account.id
      @audits = Audit.new(audit_params)
      if @audits.save
        redirect_to "/equipment", notice: 'Audit was successfully created.'
      else
        render :new
      end
    end
  end

  # PATCH/PUT /products/1
  def update
    if @audits.update(account_params)
      redirect_to @audits, notice: 'Audit was successfully updated.'
    else
      render :edit
    end
  end
audit = Audit
  # DELETE /products/1
  def destroy
    @audits.destroy
    redirect_to "/equipment", notice: 'Audit was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @audits = Audit.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def audit_params
      params.require(:audit).permit(:detail_id, :account_id, :end_time, :description)
    end
end
