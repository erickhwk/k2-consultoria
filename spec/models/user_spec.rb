require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'requires email to be present' do
      user = User.new(email: nil, password: 'password', role: 'admin')
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include("can't be blank")
    end

    it 'requires password to be present' do
      user = User.new(email: 'test@example.com', password: nil, role: 'admin')
      expect(user).not_to be_valid
      expect(user.errors[:password]).to include("can't be blank")
    end

    it 'requires role to be either admin or manager' do
      expect {
        User.new(email: 'test@example.com', password: 'password', role: 'invalid_role')
      }.to raise_error(ArgumentError, "'invalid_role' is not a valid role")
    end
  end

  describe 'associations' do
    it 'should belong to law_firm' do
      association = described_class.reflect_on_association(:law_firm)
      expect(association.macro).to eq :belongs_to
    end
  end

  describe 'behaviors' do
    it 'creates a valid user' do
      user = User.new(email: 'test@example.com', password: 'password', role: 'admin')
      expect(user).to be_valid
    end

    it 'is associated with a law firm' do
      law_firm = LawFirm.create(name: 'Example Law Firm', cnpj: '12345678901234')
      user = User.new(email: 'test@example.com', password: 'password', role: 'manager', law_firm: law_firm)
      expect(user.law_firm).to eq(law_firm)
    end
  end
end
