require 'rails_helper'

RSpec.describe Post, type: :model do
  before do
    @post = create(:post)
  end

  describe 'Post' do
    context '投稿が作成できる場合' do
      it '全ての入力が正しい場合' do
        expect(@post).to be_valid
      end

      it 'titleが30文字の場合' do
        @post.title = 'a' * 30
        expect(@post).to be_valid
      end

      it 'contentが200文字の場合' do
        @post.content = 'a' * 200
        expect(@post).to be_valid
      end
    end

    context '投稿が保存できない場合' do
      it 'user_idがない場合' do
        @post.user_id = nil
        expect(@post).to be_invalid
      end

      it 'titleがない場合' do
        @post.title = ''
        expect(@post).to be_invalid
      end

      it 'titleが31文字の場合' do
        @post.title = 'a' * 31
        expect(@post).to be_invalid
      end

      it 'contentがない場合' do
        @post.content = ''
        expect(@post).to be_invalid
      end

      it 'contentが201文字の場合' do
        @post.content = 'a' * 201
        expect(@post).to be_invalid
      end

      it 'imageがない場合' do
        @post.image = ''
        expect(@post).to be_invalid
      end
    end
  end
end
