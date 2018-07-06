class CampaignMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.campaign_mailer.raffle.subject
  #
  def raffle
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
