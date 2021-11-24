require 'rails_helper'

RSpec.describe Relationship, type: :model do
  describe 'フォロー機能' do
    before(:each) do
      @user = create(:user)
      @other_user = create(:user)
    end

    it 'フォロー' do
      @relationship = @user.relationships.find_or_create_by(follow_id: @other_user.id)
      expect(@relationship).to be_valid
    end

    it 'フォロー解除' do
      @relationship = create(:relationship)
      expect { @relationship.destroy }.to change(Relationship, :count).by(-1)
    end
  end
end
