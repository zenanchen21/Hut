class EquipmentPdfsController < ApplicationController
  before_action :set_equipment_pdf, only: [:show, :edit, :update, :destroy]
  
  authorize_resource

  # GET /equipment_pdfs
  def index
    @equipment_pdfs = EquipmentPdf.all
  end

  # GET /equipment_pdfs/1
  def show
  end

  # GET /equipment_pdfs/new
  def new
    @equipment_pdf = EquipmentPdf.new
  end

  # GET /equipment_pdfs/1/edit
  def edit
  end

  # POST /equipment_pdfs
  def create
    @equipment_pdf = EquipmentPdf.new(equipment_pdf_params)

    if @equipment_pdf.save
      redirect_to @equipment_pdf, notice: 'Equipment pdf was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /equipment_pdfs/1
  def update
    if @equipment_pdf.update(equipment_pdf_params)
      redirect_to @equipment_pdf, notice: 'Equipment pdf was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /equipment_pdfs/1
  def destroy
    @equipment_pdf.destroy
    redirect_to equipment_pdfs_url, notice: 'Equipment pdf was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_equipment_pdf
      @equipment_pdf = EquipmentPdf.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def equipment_pdf_params
      params.require(:equipment_pdf).permit(:equipment_id, :pdf_id)
    end
end
