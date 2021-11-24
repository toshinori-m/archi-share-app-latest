require 'rails_helper'

RSpec.describe Relationship, type: :request do
  describe 'Relationship' do
    before(:each) do
      @user = create(:user)
      @other_user = create(:user)
    end

    it 'ユーザーをフォロー' do
      post '/api/v1/relationships', params: { user_id: @user.id, follow_id: @other_user.id }
      expect(response).to have_http_status(:created)
    end

    it 'ユーザーをフォロー解除' do
      @relationship = create(:relationship)
      delete '/api/v1/relationships', params: { user_id: @relationship.user_id, follow_id: @relationship.follow_id }
      expect(response).to have_http_status(:ok)
    end
  end
end
