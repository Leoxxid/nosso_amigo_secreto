require 'rails_helper'

RSpec.describe CampaignRaffleJob, type: :job do

  include ActiveJob::TestHelper

  @user = FactoryBot.create(:user)
  @campaign = FactoryBot.create(:campaign, user: @user)

  subject(:job) { CampaignRaffleJob.perform_later(@campaign) }

  it { is_expected.to be_processed_in :emails }

  it 'queues the job' do
    expect { job }
      .to change(ActiveJob::Base.queue_adapter.enqueued_jobs, :size).by(1)
  end

  it 'Check if campaign has enqueued job' do
    expect{job}.to have_enqueued_job(@campaign)
  end

end
