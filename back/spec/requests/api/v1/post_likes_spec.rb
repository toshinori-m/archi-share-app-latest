require 'rails_helper'

RSpec.describe PostLike, type: :request do
  describe 'いいね機能' do
    before do
      @user = create(:user)
      @post = create(:post)
      @postlike = create(:post_like)
    end

    context '投稿をいいね・いいね解除できる場合' do
      it '投稿をいいね' do
        post '/api/v1/post_likes', params: { user_id: @user.id, post_id: @post.id }
        expect(response).to have_http_status(:created)
      end

      it '投稿をいいね解除' do
        delete '/api/v1/post_likes', params: { user_id: @postlike.user_id, post_id: @postlike.post_id }
        expect(response.status).to eq(200)
      end
    end

    context '投稿をいいねできない場合' do
      it 'user_idがない場合' do
        post '/api/v1/post_likes', params: { user_id: nil, post_id: @post.id }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'post_idがない場合' do
        post '/api/v1/post_likes', params: { user_id: @user.id, post_id: nil }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'すでにいいねしている場合' do
        post '/api/v1/post_likes', params: { user_id: @postlike.user_id, post_id: @postlike.post_id }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context '投稿をいいね解除できない場合' do
      it 'いいねしていない投稿のいいね解除の場合' do
        delete '/api/v1/post_likes', params: { user_id: @user.id, post_id: @post.id }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
