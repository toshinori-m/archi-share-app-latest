require 'rails_helper'

RSpec.describe Api::V1::CommentsController, type: :request do
  describe 'POST /api/v1/comments' do
    subject(:request) { post api_v1_comments_path, params: params }
    let(:user) { create(:user) }
    let(:target_post) { create(:post) }

    context 'paramsの値が正しい場合' do
      let(:params) { { content: 'コメント', user_id: user.id, post_id: target_post.id } }

      it 'コメントを作成出来ること' do
        expect { request }.to change(Comment, :count).by(+1)
      end
    end

    context 'paramsの値が正しくない場合' do
      let(:params) { { content: '', user_id: user.id, post_id: target_post.id } }

      it 'コメントを作成出来ないこと' do
        request
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /api/v1/comments' do
    subject(:request) { delete api_v1_comment_path(comment.id) }
    let!(:comment) { create(:comment) }

    it '特定のコメントを削除出来ること' do
      expect { request }.to change(Comment, :count).by(-1)
    end
  end
end
