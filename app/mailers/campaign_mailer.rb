class CampaignMailer < ApplicationMailer
  include Rails.application.routes.url_helpers

  def raffle(campaign, member, friend)
    @campaign = campaign
    @member = member
    @friend = friend
    mail to: @member.email, subject: "Nosso Amigo Secreto: #{@campaign.title}"
  end

  def raffle_failed(campaign)
    @campaign = campaign
    @owner = campaign.user
    @campaign_link = ActionMailer::Base.default_url_options[:host] + campaign_path(@campaign.id)
    mail to: @owner.email, subject: 'Nosso Amigo Secreto: Falha ao criar campanha'
  end
end
