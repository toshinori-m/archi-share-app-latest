require 'rails_helper'

RSpec.describe Api::V1::ArchitecturesController, type: :request do
  describe 'GET /api/v1/architectures' do
    subject(:request) { get api_v1_architectures_path }
    let!(:architecture) { create(:architecture) }

    it '建築物の一覧を取得出来ること' do
      request
      expect(response).to have_http_status(:ok)
      parsed_body = JSON.parse(response.body)
      expect(parsed_body.size).to eq 1
    end
  end

  describe 'GET /api/v1/architectures/:id' do
    subject(:request) { get api_v1_architecture_path(architecture.id) }
    let!(:architecture) { create(:architecture) }

    it '特定の建築物を取得出来ること' do
      request
      expect(response).to have_http_status(:ok)
      parsed_body = JSON.parse(response.body)
      expect(parsed_body['id']).to eq architecture.id
    end
  end

  describe 'POST /api/v1/architectures' do
    subject(:request) { post api_v1_architectures_path, params: params }

    context 'paramsの値が正しい場合' do
      let(:params) do
        {
          name: '東京駅',
          prefecture: '東京都',
          address: '千代田区丸の内１丁目',
          lat: 35.68,
          lng: 139.76,
          construction: '鉄筋コンクリート造',
          designer: '辰野金吾',
          above_floor: '地上３階',
          under_floor: '地下２階',
          image: image
        }
      end
      let(:image) { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/sample.jpg')) }

      it '建築物を作成出来ること' do
        expect { request }.to change(Architecture, :count).by(+1)
      end
    end

    context 'paramsの値が正しくない場合' do
      let(:params) do
        {
          name: '',
          prefecture: '東京都',
          address: '千代田区丸の内１丁目',
          lat: 35.68,
          lng: 139.76,
          construction: '鉄筋コンクリート造',
          designer: '辰野金吾',
          above_floor: '地上３階',
          under_floor: '地下２階',
          image: image
        }
      end
      let(:image) { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/sample.jpg')) }

      it '建築物を作成出来ないこと' do
        request
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /api/v1/architectures/:id' do
    subject(:request) { delete api_v1_architecture_path(architecture.id) }
    let!(:architecture) { create(:architecture) }

    it '特定の建築物を削除出来ること' do
      expect { request }.to change(Architecture, :count).by(-1)
    end
  end
end
