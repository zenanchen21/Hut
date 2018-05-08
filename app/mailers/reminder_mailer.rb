class ReminderMailer < ApplicationMailer
  def notify_tech(reminder, tech, detail)
    @reminder = reminder
    @tech = tech
    @detail = detail
    mail(to: detail.owner.email, subject: 'new report')
  end
end
