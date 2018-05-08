require 'time'
# require 'pg'

class BackupController < ApplicationController
  before_action :set_equipment, only: [:show, :edit, :update, :destroy, :add]

#-  authorize_resource

  # GET /backup
  def index
    send_data Equipment.to_csv("#{current_account.givenname} Downloaded Equipment csv file"), filename: "equipment-#{Date.today}.csv"
    # send_data Account.to_csv('Chevy'), filename: "account-#{Date.today}.csv"
    # send_data AccountsTraining.to_csv('Chevy'), filename: "accountsTraining-#{Date.today}.csv"
    # send_data Audit.to_csv('Chevy'), filename: "audit-#{Date.today}.csv"
    # send_data DetailRequest.to_csv('Chevy'), filename: "detailRequest-#{Date.today}.csv"
    # send_data Detail.to_csv('Chevy'), filename: "detail-#{Date.today}.csv"
    # send_data EquipmentPdf.to_csv('Chevy'), filename: "equipmentPdf-#{Date.today}.csv"
    # send_data EquipmentTraining.to_csv('Chevy'), filename: "equipmentTraining-#{Date.today}.csv"
    # send_data LifespanAlteration.to_csv('Chevy'), filename: "lifespanAlteration-#{Date.today}.csv"
    # send_data Location.to_csv('Chevy'), filename: "location-#{Date.today}.csv"
    # send_data Log.to_csv('Chevy'), filename: "log-#{Date.today}.csv"
    # send_data PdfType.to_csv('Chevy'), filename: "pdfType-#{Date.today}.csv"
    # send_data Pdf.to_csv('Chevy'), filename: "pdf-#{Date.today}.csv"
    # send_data Report.to_csv('Chevy'), filename: "report-#{Date.today}.csv"
    # send_data ServiceReminder.to_csv('Chevy'), filename: "serviceReminder-#{Date.today}.csv"
    # send_data Training.to_csv('Chevy'), filename: "training-#{Date.today}.csv"
  end

  def updateAvailabilities
  end

  def add
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    # def set_equipment
    #   @equipment = Equipment.find(params[:id])
    # end
    #
    # # Only allow a trusted parameter "white list" through.
    # def equipment_params
    #   params.require(:equipment).permit(:name, :consumable, :description, :avatar, :expectant_expectancy, :avatar_file_cache)
    # end
end
