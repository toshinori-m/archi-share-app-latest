require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :request do
  let!(:user) { create(:user) }

  describe 'GET /api/v1/users' do
    subject(:request) { get api_v1_users_path }

    it 'ユーザーの一覧を取得出来ること' do
      request
      expect(response).to have_http_status(:ok)
      parsed_body = JSON.parse(response.body)
      expect(parsed_body.size).to eq 1
    end
  end

  describe 'GET /api/v1/users/:id' do
    subject(:request) { get api_v1_user_path(user.id) }

    it '特定のユーザーを取得出来ること' do
      request
      expect(response).to have_http_status(:ok)
      parsed_body = JSON.parse(response.body)
      expect(parsed_body['id']).to eq user.id
    end
  end

  describe 'DELETE /api/v1/users/:id' do
    subject(:request) { delete api_v1_user_path(user.id) }

    it '特定のユーザーを削除出来ること' do
      expect { request }.to change(User, :count).by(-1)
    end
  end
end
