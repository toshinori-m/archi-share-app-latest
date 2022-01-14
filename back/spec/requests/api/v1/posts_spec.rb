require 'rails_helper'

RSpec.describe Post, type: :request do
  describe 'Post' do
    before(:each) do
      @post = create(:post)
    end

    it '投稿の一覧の取得' do
      get '/api/v1/posts'
      expect(response.status).to eq(200)
    end

    it '特定の投稿の取得' do
      get "/api/v1/posts/#{@post.id}"
      expect(json['title']).to eq(@post.title)
    end

    context '投稿の作成' do
      before do
        @user = create(:user)
      end

      it '投稿が作成できる場合' do
        image = Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/sample.jpg'))
        params = { title: 'a', content: 'a', image: image, user_id: @user.id }
        expect { post '/api/v1/posts', params: params }.to change { Post.count }.by(+1)
      end

      it '投稿が作成できない場合' do
        image = Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/sample.jpg'))
        params = { title: 'a', content: '', image: image, user_id: @user.id }
        post '/api/v1/posts', params: params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context '投稿の更新' do
      it '投稿が更新できる場合' do
        params = { title: 'b', content: 'b', user_id: @post.user_id }
        put "/api/v1/posts/#{@post.id}", params: params
        expect(json['title']).to eq('b')
      end

      it '投稿が更新できない場合' do
        params = { title: '', content: 'b', user_id: @post.user_id }
        put "/api/v1/posts/#{@post.id}", params: params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    it '特定の投稿の削除' do
      expect { delete "/api/v1/posts/#{@post.id}" }.to change { Post.count }.by(-1)
    end
  end
end
