require 'rails_helper'

RSpec.describe 'Api::V1::Comments', type: :request do
  describe 'Comment' do
    before do
      @user = create(:user)
      @post = create(:post)
    end

    context '投稿にコメント' do
      it '投稿にコメントできる場合' do
        post '/api/v1/comments',
             params: { user_id: @user.id, post_id: @post.id, content: 'a' * 50 }
        expect(response).to have_http_status(:created)
      end

      it '投稿にコメントできない場合' do
        post '/api/v1/comments',
             params: { user_id: nil, post_id: @post.id, content: 'a' * 50 }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    it '特定のコメントを削除' do
      @comment = create(:comment)
      expect { delete "/api/v1/comments/#{@comment.id}" }.to change { Comment.count }.by(-1)
    end
  end
end
