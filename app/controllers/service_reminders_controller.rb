class ServiceRemindersController < ApplicationController
  before_action :set_service_reminder, only: [:show, :edit, :update, :destroy]

  # GET /service_reminders
  def index
    if current_account.admin?
      @service_reminders = ServiceReminder.where(is_serviced: false)
    else
      @service_reminders = ServiceReminder.where(is_serviced: false).where(:detail_id => Detail.where(account_id: current_account[:id]).pluck(:id))
    end
  end

  # GET /service_reminders/1/edit
  def edit
  end
  # PATCH/PUT /service_reminders/1
  def update
    if @service_reminder.update(is_serviced: true, description: service_reminder_params["description"])
      redirect_to '/service_reminder', notice: 'Service reminder was successfully updated.'
    else
      render :edit
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_service_reminder
      @service_reminder = ServiceReminder.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def service_reminder_params
      params.require(:service_reminder).permit(:detail_id, :description)
    end
end
