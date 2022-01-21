require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'Comment' do
    before do
      @comment = create(:comment)
    end

    context 'コメントできる場合' do
      it '全ての値が正しい場合' do
        expect(@comment).to be_valid
      end

      it 'contentが1文字の場合' do
        @comment.content = 'a'
        expect(@comment).to be_valid
      end

      it 'contentが150文字の場合' do
        @comment.content = 'a' * 150
        expect(@comment).to be_valid
      end
    end

    context 'コメントできない場合' do
      it 'contentがない場合' do
        @comment.content = ''
        expect(@comment).to be_invalid
      end

      it 'user_idがない場合' do
        @comment.user_id = nil
        expect(@comment).to be_invalid
      end

      it 'post_idがない場合' do
        @comment.post_id = nil
        expect(@comment).to be_invalid
      end

      it 'contentが151文字の場合' do
        @comment.content = 'a' * 151
        expect(@comment).to be_invalid
      end
    end
  end
end
