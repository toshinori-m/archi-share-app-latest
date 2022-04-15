require 'rails_helper'

RSpec.describe Api::V1::PostLikesController, type: :request do
  let!(:user) { create(:user) }
  let!(:target_post) { create(:post) }

  describe 'POST /api/v1/post_likes' do
    subject(:request) { post api_v1_post_likes_path, params: params }

    context 'paramsの値が正しい場合' do
      let(:params) { { user_id: user.id, post_id: target_post.id } }

      it 'いいね出来ること' do
        expect { request }.to change(PostLike, :count).by(+1)
      end
    end

    context 'paramsの値が正しくない場合' do
      let(:params) { { user_id: nil, post_id: target_post.id } }

      it 'いいね出来ないこと' do
        request
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /api/v1/post_likes' do
    subject(:request) { delete api_v1_post_likes_path, params: params }
    let!(:post_like) { create(:post_like) }
    let(:params) { { user_id: post_like.user_id, post_id: post_like.post_id } }

    it 'いいねを削除出来ること' do
      expect { request }.to change(PostLike, :count).by(-1)
    end
  end
end
