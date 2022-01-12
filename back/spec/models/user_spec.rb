require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = create(:user)
  end

  describe 'ユーザー登録' do
    context 'ユーザーを登録できる場合' do
      it '全ての入力が正しい場合、有効である' do
        expect(@user).to be_valid
      end
    end
  end

  describe 'インスタンスメソッドのテスト' do
    before do
      @post = create(:post)
    end

    context 'unlike' do
      it 'ユーザーがいいね済みの投稿の場合' do
        @post_like = create(:post_like, user_id: @user.id, post_id: @post.id)
        expect { @user.unlike(@post) }.to change { PostLike.count }.by(-1)
      end

      it 'ユーザーがいいねしていない投稿の場合' do
        expect { @user.unlike(@post) }.to change { PostLike.count }.by(0)
      end
    end
  end
end
