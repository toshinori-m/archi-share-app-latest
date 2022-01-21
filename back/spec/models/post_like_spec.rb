require 'rails_helper'

RSpec.describe PostLike, type: :model do
  describe 'いいね機能' do
    before do
      @postlike = create(:post_like)
    end

    context 'いいねできる場合' do
      it '全ての値が正しい場合' do
        expect(@postlike).to be_valid
      end

      it 'post_idが同じでuser_idが異なる場合' do
        @like = create(:post_like, post_id: @postlike.post_id)
        expect(@like).to be_valid
      end

      it 'user_idが同じでpost_idが異なる場合' do
        @like = create(:post_like, user_id: @postlike.user_id)
        expect(@like).to be_valid
      end
    end

    context 'いいねできない場合' do
      it 'user_idがない場合' do
        @postlike.user_id = nil
        expect(@postlike).to be_invalid
      end

      it 'post_idがない場合' do
        @postlike.post_id = nil
        expect(@postlike).to be_invalid
      end
    end

    context '一意性の検証' do
      it 'user_idとpost_idの組み合わせは一意であること' do
        @like = build(:post_like, user_id: @postlike.user_id, post_id: @postlike.post_id)
        expect(@like).to be_invalid
      end
    end
  end
end
