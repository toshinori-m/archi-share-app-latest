require 'rails_helper'

RSpec.describe Relationship, type: :request do
  describe 'フォロー機能' do
    before(:each) do
      @user = create(:user)
      @other_user = create(:user)
    end

    context 'ユーザーをフォロー・フォロー解除できる場合' do
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

    context 'ユーザーをフォロー・フォロー解除できない場合' do
      it 'フォローしていないユーザーへのフォロー解除をした場合' do
        delete '/api/v1/relationships', params: { user_id: @user.id, follow_id: @other_user.id }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
