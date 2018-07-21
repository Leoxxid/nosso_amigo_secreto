require 'rails_helper'

RSpec.describe MembersController, type: :controller do
  include Devise::Test::ControllerHelpers

  before(:each) do
    @request.env['devise.mapping'] = Devise.mappings[:user]
    @current_user = FactoryBot.create(:user)
    sign_in @current_user

    @campaign = FactoryBot.create(:campaign, user: @current_user)
    @member = FactoryBot.create(:member, campaign_id: @campaign.id)
    @member_attributes = attributes_for(:member, campaign_id: @campaign.id)
  end

  describe "POST #create" do
    it "returns http success" do
      post :create, params: { member: @member_attributes }, format: :json
      expect(response).to have_http_status(:success)
    end
  end

  describe "DELETE #destroy" do

    context "when current_user is owner of campaign" do
      it "returns http success" do
        delete :destroy, params: { id: @member.id }, format: :json
        expect(response).to have_http_status(:success)

        member = Member.where(id: @member.id)
        expect(member).not_to be_present
      end
    end

    context "when current_user is not the owner of campaign" do
      user = FactoryBot.create(:user)
      campaign = FactoryBot.create(:campaign, user: user)
      member = FactoryBot.create(:member, campaign_id: campaign.id)
      it ' return forbidden' do
        delete :destroy, params: { id: member.id }, format: :json
        expect(response).to have_http_status(:forbidden)
      end
    end
  end
  #
  describe "PUT #update" do
    before(:each) do
      @new_member_attributes = attributes_for(:member)
    end

    context "when current_user is owner of campaign" do
      before(:each) do
        put :update, params: {id: @member.id, member: @member_attributes},
            format: :json
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "Member have new attributes" do
        edited_member = Member.find(@member.id)
        expect(edited_member.name).to eql(@member_attributes[:name])

        expect(edited_member.email).to eql(@member_attributes[:email])
      end
    end

    context "when current_user is not the owner of campaign" do
      user = FactoryBot.create(:user)
      campaign = FactoryBot.create(:campaign, user: user)
      member = FactoryBot.create(:member, campaign_id: campaign.id)
      it ' return forbidden' do
        put :update, params: { id: member.id }, format: :json
        expect(response).to have_http_status(:forbidden)
      end
    end

    describe "GET #opened" do
      it 'change open attribute to true' do
        @member.set_pixel
        get :opened, params: { token: @member.token }

        member = Member.find_by!(token: @member.token)

        expect(member.open).to be_truthy
      end
    end
  end
end
