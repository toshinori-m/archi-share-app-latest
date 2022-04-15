require 'rails_helper'

RSpec.describe Api::V1::RelationshipsController, type: :request do
  let!(:user) { create(:user) }
  let!(:target_user) { create(:user) }

  describe 'POST /api/v1/relationships' do
    subject(:request) { post api_v1_relationships_path, params: params }

    context 'paramsの値が正しい場合' do
      let(:params) { { user_id: user.id, follow_id: target_user.id } }

      it 'ユーザーをフォロー出来ること' do
        expect { request }.to change(Relationship, :count).by(+1)
      end
    end
  end

  describe 'DELETE /api/v1/relationships' do
    subject(:request) { delete api_v1_relationships_path, params: params }
    let!(:relationship) { create(:relationship) }

    context 'paramsの値が正しい場合' do
      let(:params) { { user_id: relationship.user_id, follow_id: relationship.follow_id } }

      it 'フォローを解除出来ること' do
        expect { request }.to change(Relationship, :count).by(-1)
      end
    end
  end
end
