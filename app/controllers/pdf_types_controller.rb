class PdfTypesController < ApplicationController
  before_action :set_pdf_type, only: [:show, :edit, :update, :destroy]

  # GET /pdf_types
  def index
    @pdf_types = PdfType.all
  end

  # GET /pdf_types/1
  def show
  end

  # GET /pdf_types/new
  def new
    @pdf_type = PdfType.new
  end

  # GET /pdf_types/1/edit
  def edit
  end

  # POST /pdf_types
  def create
    @pdf_type = PdfType.new(pdf_type_params)

    if @pdf_type.save
      redirect_to @pdf_type, notice: 'Pdf type was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /pdf_types/1
  def update
    if @pdf_type.update(pdf_type_params)
      redirect_to @pdf_type, notice: 'Pdf type was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /pdf_types/1
  def destroy
    @pdf_type.destroy
    redirect_to pdf_types_url, notice: 'Pdf type was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pdf_type
      @pdf_type = PdfType.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def pdf_type_params
      params.require(:pdf_type).permit(:name)
    end
end
