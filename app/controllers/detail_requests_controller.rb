class DetailRequestsController < ApplicationController
  before_action :set_detail_request, only: [:show, :edit, :update, :destroy]

  authorize_resource

  # GET /detail_requests
  def index
    @detail_requests = DetailRequest.all
    @equipment_requests = Equipment.where(approved: false)
    @lifespan_alterations = LifespanAlteration.all
  end

  def approve_extension
    alteration = LifespanAlteration.find(params[:id])
    alteration.detail.update(life_expectancy: alteration.detail.life_expectancy + alteration.extension)
    LifespanAlteration.find(params[:id]).destroy
    redirect_to "/detail_requests", notice: 'Extension approved.'
  end

  def reject_extension
    LifespanAlteration.find(params[:id]).destroy
    redirect_to "/detail_requests", notice: 'Extension approved.'
  end

  def approve_equipment
    Equipment.find(params[:id]).update(approved: true)
    redirect_to "/detail_requests", notice: 'Equipment approved.'
  end

  def deny_equipment
    Equipment.find(params[:id]).destroy
    redirect_to "/detail_requests", notice: 'Equipment rejected.'
  end

  # GET /detail_requests/1
  def show
  end

  # GET /detail_requests/new
  def new
    @detail_request = DetailRequest.new
  end

  # GET /detail_requests/1/edit
  def edit
  end

  # POST /detail_requests
  def create
    @detail_request = DetailRequest.new(detail_request_params)

    if @detail_request.save
      redirect_to @detail_request, notice: 'Equipment request was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /detail_requests/1
  def update
    if @detail_request.update(detail_request_params)
      redirect_to @detail_request, notice: 'Equipment request was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /detail_requests/1
  def destroy
    @detail_request.destroy
    redirect_to detail_requests_url, notice: 'Equipment request was successfully destroyed.'
  end

  def approve
    detailRequest = DetailRequest.find(params[:id])
    Detail.find(detailRequest.detail_id).update(active: detailRequest.archived_new_value)
    Log.create(account_id: current_account[:id], action: "Approved request to update detail #{detailRequest.detail_id} to archived: #{detailRequest.archived_new_value}")
    detailRequest.destroy
    redirect_to "/detail_requests", notice: 'Detail was updated.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_detail_request
      @detail_request = DetailRequest.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def detail_request_params
      params.require(:detail_request).permit(:equipment_id, :archived_new_value)
    end
end
