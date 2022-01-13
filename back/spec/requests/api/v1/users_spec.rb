require 'rails_helper'
RSpec.describe User, type: :request do
  describe 'User' do
    before(:each) do
      @user = create(:user)
    end

    it 'ユーザーの一覧の取得' do
      get '/api/v1/users'
      expect(response.status).to eq(200)
    end

    it '特定のユーザーの取得' do
      get "/api/v1/users/#{@user.id}"
      expect(json['name']).to eq(@user.name)
    end

    it '特定のユーザーの削除' do
      expect { delete "/api/v1/users/#{@user.id}" }.to change { User.count }.by(-1)
    end
  end
end
