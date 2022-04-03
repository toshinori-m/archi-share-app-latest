require 'rails_helper'

RSpec.describe Api::V1::PostsController, type: :request do
  describe 'GET /api/v1/posts' do
    subject(:request) { get api_v1_posts_path }
    let!(:post) { create(:post) }

    it '投稿の一覧を取得出来ること' do
      request
      expect(response).to have_http_status(:ok)
      parsed_body = JSON.parse(response.body)
      expect(parsed_body.size).to eq 1
    end
  end

  describe 'GET /api/v1/posts/:id' do
    subject(:request) { get api_v1_post_path(post.id) }
    let!(:post) { create(:post) }

    it '特定の投稿を取得出来ること' do
      request
      expect(response).to have_http_status(:ok)
      parsed_body = JSON.parse(response.body)
      expect(parsed_body['id']).to eq post.id
    end
  end

  describe 'POST /api/v1/posts' do
    subject(:request) { post api_v1_posts_path, params: params }
    let(:image) { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/sample.jpg')) }
    let(:user) { create(:user) }

    context 'paramsの値が正しい場合' do
      let(:params) { { title: 'タイトル', content: '内容', image: image, user_id: user.id } }

      it '投稿を作成出来ること' do
        expect { request }.to change(Post, :count).by(+1)
      end
    end

    context 'paramsの値が正しくない場合' do
      let(:params) { { title: 'タイトル', content: '', image: image, user_id: user.id } }

      it '投稿を作成出来ないこと' do
        request
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH /api/v1/posts/:id' do
    subject(:request) { patch api_v1_post_path(post.id), params: params }
    let!(:post) { create(:post) }

    context 'paramsの値が正しい場合' do
      let(:params) { { title: '投稿' } }

      it '投稿を更新出来ること' do
        request
        parsed_body = JSON.parse(response.body)
        expect(parsed_body['title']).to eq '投稿'
      end
    end

    context 'paramsの値が正しくない場合' do
      let(:params) { { title: '' } }

      it '投稿を更新出来ないこと' do
        request
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /api/v1/posts/:id' do
    subject(:request) { delete api_v1_post_path(post.id) }
    let!(:post) { create(:post) }

    it '特定の投稿を削除出来ること' do
      expect { request }.to change(Post, :count).by(-1)
    end
  end
end
