require 'rails_helper'

RSpec.describe Architecture, type: :request do
  describe 'Architecture' do
    it '建築物の一覧の取得' do
      get '/api/v1/architectures'
      expect(response.status).to eq(200)
    end

    it '特定の建築物の取得' do
      @architecture = create(:architecture)
      get "/api/v1/architectures/#{@architecture.id}"
      expect(json['name']).to eq(@architecture.name)
    end

    it '建築物の作成' do
      params = { name: 'a', prefecture: '北海道', address: 'a', construction: '木造',
                 designer: 'a', above_floor: '1階', under_floor: '地下1階', lat: 36, lng: 130,
                 image: Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/sample.jpg')) }
      expect { post '/api/v1/architectures', params: params }.to change { Architecture.count }.by(+1)
    end

    it '建築物の作成ができない場合' do
      @architecture = create(:architecture, name: 'a')
      params = { name: 'a', prefecture: '北海道', address: 'a', construction: '木造',
                 designer: 'a', above_floor: '1階', under_floor: '地下1階', lat: 36, lng: 130,
                 image: Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/sample.jpg')) }
      post '/api/v1/architectures', params: params
      expect(json['message']['name'][0]).to eq('has already been taken')
    end

    it '特定の建築物の削除' do
      @architecture = create(:architecture)
      expect { delete "/api/v1/architectures/#{@architecture.id}" }.to change { Architecture.count }.by(-1)
    end
  end
end
