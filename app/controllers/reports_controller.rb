class ReportsController < ApplicationController
  before_action :set_report, only: [:show, :edit, :update, :destroy]

  authorize_resource

  # GET /reports
  def index
    @reports = Report.order('urgency DESC').order('created_at').where(resolved_by: "") + Report.order('urgency DESC').order('created_at').where.not(resolved_by: "")
  end

  # GET /reports/1
  def show
  end

  # GET /reports/new
  def new
    @report = Report.new
  end

  # GET /reports/1/edit
  def edit
    puts params[:id]
    puts "***************"
    @detail = Report.find(params[:id]).audit.detail
  end

  # POST /reports
  def create
    d = Audit.find(params[:report][:audit_id]).detail
    @report = Report.new(report_new_params)
    @report.resolved_by = ""
    if @report.save

      ReportMailer.notify_tech(@report, Account.system_tech, d).deliver_now
      redirect_to @report, notice: 'Report was successfully created.'
    else
      render :new
    end
  end


  # PATCH/PUT /reports/1
  def update
    audit_id = Report.find(report_update_params[:id]).audit_id
    if(report_update_params[:request_deactivation])
      @detail_request = DetailRequest.create({detail_id: Audit.find(audit_id).detail_id, archived_new_value: false})
    end
    d = Audit.find(audit_id).detail

    if current_account.admin?
      d.update(life_expectancy: d.life_expectancy + report_update_params[:extend_lifetime].to_i)
    else
      LifespanAlteration.create(detail_id: d[:id], extension: report_update_params[:extend_lifetime].to_i)
    end

    if @report.update(report_update_params)
      redirect_to "/reports", notice: 'Report was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /reports/1
  def destroy
    @report.destroy
    redirect_to reports_url, notice: 'Report was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_report
      @report = Report.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def report_new_params
      params.require(:report).permit(:audit_id, :description, :urgency)
    end
    def report_update_params
      params.require(:report).permit(:id, :fixing_logs, :resolved_by, :urgency, :extend_lifetime, :request_deactivation)
    end
end
