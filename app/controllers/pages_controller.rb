class PagesController < ApplicationController
  def home
    redirect_to campaigns_index_path if current_user.campaigns.present?
  end
end
