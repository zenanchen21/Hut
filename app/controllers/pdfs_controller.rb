class PdfsController < ApplicationController
  before_action :set_pdf, only: [:show, :edit, :update, :destroy]

  # GET /products
  def index
    @pdfs = Pdf.all
  end

  # GET /products/1
  def show
    @pdf = Pdf.find(params[:id])
    redirect_to @pdf.pdf.url, notice: 'Pdf was successfully created.'
  end


  def show_pdf
  end

  # GET /products/new
  def new
    @pdfs = Pdf.new
    @pdf_types = PdfType.all
  end

  # GET /products/1/edit
  def edit
  end

  def add_equipment
    if params[:p_id]
      EquipmentPdf.create(equipment_id: params[:e_id], pdf_id: params[:p_id])
      redirect_to "/equipment/#{params[:e_id]}", notice: 'Pdf was successfully linked.'
    else
      @pdfs = Pdf.all - Equipment.find(params[:e_id]).pdfs
    end
  end

  # POST /products
  def create
    @pdf_types = PdfType.all
    @pdfs = Pdf.new(pdf_params)

    if @pdfs.save
      redirect_to pdfs_path, notice: 'Pdf was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /products/1
  def update
    if @pdfs.update(pdf_params)
      redirect_to @pdfs, notice: 'Pdf was successfully updated.'
    else
      render :edit
    end
  end
pdfs = Pdf
  # DELETE /products/1
  def destroy
    @pdfs.destroy
    redirect_to pdfs_path, notice: 'Pdf was successfully destroyed.'
  end

  # POST /pdfs/search
  def search
    # {"search" => {"name" => "some entered name"} }
    pdfTypeIDs = PdfType.where(name: params[:search][:name]).pluck(:id)
    @pdfs = Pdf.where("lower (name) LIKE :query", query: "%#{params[:search][:name].downcase}%").or(Pdf.where(id: params[:search][:name])).or(Pdf.where(:pdf_type_id => pdfTypeIDs))
    @searched = true
    render :index
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pdf
      @pdfs = Pdf.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def pdf_params
      params.require(:pdf).permit(:pdf, :pdf_type_id, :name, :description, :pdf_file_cache)
    end
end
