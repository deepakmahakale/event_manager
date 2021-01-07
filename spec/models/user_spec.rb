require 'rails_helper'

RSpec.describe User, type: :model do
  # let(:user) { create(:user) }

  context '#validations' do
    it 'username: minimum 1 character' do
      user = build(:user, username: '')
      expect(user.valid?).to be false
      byebug
      expect(user.errors.messages[:username]).to include('is too short (minimum is 1 character)')
    end

    it 'username: only alphanumeric characters and underscore' do
      user = build(:user, username: 'user+$')
      expect(user.valid?).to be false
      expect(user.errors.messages[:username]).to include('Only alphanumeric characters and _ is allowed')
    end

    it 'username: should be unique' do
      create(:user, username: 'username123')
      user2 = build(:user, username: 'username123')

      expect(user2.valid?).to be false
      expect(user2.errors.messages[:username]).to include('has already been taken')
    end
  end
end
