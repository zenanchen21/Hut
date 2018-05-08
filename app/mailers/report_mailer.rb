class ReportMailer < ApplicationMailer
  def notify_tech(report, tech, detail)
    @report = report
    @tech = tech
    @detail = detail
    mail(to: detail.owner.email, subject: 'new report')
  end
end
