class PagesController < ApplicationController
  def home
    if current_user
      redirect_to campaigns_index_path if current_user.campaigns.present?
    end
  end
end
