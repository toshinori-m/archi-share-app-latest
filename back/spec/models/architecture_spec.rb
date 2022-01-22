require 'rails_helper'

RSpec.describe Architecture, type: :model do
  describe 'Architecture' do
    before do
      @architecture = create(:architecture)
    end

    context '建築物を登録できる場合' do
      it '全ての値が正しい場合' do
        expect(@architecture).to be_valid
      end

      it 'nameが30文字の場合' do
        @architecture.name = 'a' * 30
        expect(@architecture).to be_valid
      end

      it 'addressが50文字の場合' do
        @architecture.address = 'a' * 50
        expect(@architecture).to be_valid
      end
    end

    context '建築物を登録できない場合' do
      it 'nameがない場合' do
        @architecture.name = nil
        expect(@architecture).to be_invalid
      end

      it 'nameが31文字の場合' do
        @architecture.name = 'a' * 31
        expect(@architecture).to be_invalid
      end

      it 'prefectureが選択されていない場合' do
        @architecture.prefecture = nil
        expect(@architecture).to be_invalid
      end

      it 'addressがない場合' do
        @architecture.address = nil
        expect(@architecture).to be_invalid
      end

      it 'addressが51文字の場合' do
        @architecture.address = 'a' * 51
        expect(@architecture).to be_invalid
      end

      it 'latがない場合' do
        @architecture.lat = nil
        expect(@architecture).to be_invalid
      end

      it 'lngがない場合' do
        @architecture.lng = nil
        expect(@architecture).to be_invalid
      end

      it 'imageがない場合' do
        @architecture.image = nil
        expect(@architecture).to be_invalid
      end
    end

    context '一意性の検証' do
      it 'nameが一意であること' do
        @other_architecture = build(:architecture)
        expect(@other_architecture).to be_invalid
      end
    end
  end
end
