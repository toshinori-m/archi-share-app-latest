require 'rails_helper'

RSpec.describe Post, type: :model do
  before do
    @post = create(:post)
  end

  describe '投稿作成' do
    context '投稿が作成できる場合' do
      it '全ての入力が正しい場合、有効である' do
        expect(@post).to be_valid
      end
    end

    context '投稿が保存できない場合' do
      it 'user_idがない場合、無効である' do
        @post.user_id = nil
        expect(@post).to be_invalid
      end

      it 'タイトルがない場合、無効である' do
        @post.title = ''
        expect(@post).to be_invalid
      end

      it '本文がない場合、無効である' do
        @post.content = ''
        expect(@post).to be_invalid
      end

      it '画像がない場合、無効である' do
        @post.image = ''
        expect(@post).to be_invalid
      end
    end
  end
end
