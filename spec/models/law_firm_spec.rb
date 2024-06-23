require 'rails_helper'
require "cpf_cnpj"

RSpec.describe LawFirm, type: :model do
    before(:each) do
        LawFirm.destroy_all
    end

    it "is valid with valid attributes" do
        law_firm = LawFirm.new(name: "Example Law Firm", cnpj: CNPJ.generate, contact_email: "teste@gmail.com")
        expect(law_firm).to be_valid
    end

    it "is not valid without a name" do
        law_firm = LawFirm.new(cnpj: CNPJ.generate, contact_email: "teste@gmail.com")
        expect(law_firm).to_not be_valid
    end

    it "is not valid without a cnpj" do
        law_firm = LawFirm.new(name: "Example Law Firm", contact_email: "teste@gmail.com")
        expect(law_firm).to_not be_valid
    end

    it "is not valid without an email" do
        law_firm = LawFirm.new(name: "Example Law Firm", cnpj: CNPJ.generate)
        expect(law_firm).to_not be_valid
    end

    it "is not valid with more than one registered law firm" do
        first_law_firm = LawFirm.new(name: "Example Law Firm", cnpj: CNPJ.generate, contact_email: "teste@gmail.com")
        first_law_firm.save
        second_law_firm = LawFirm.new(name: "Example Law Firm", cnpj: CNPJ.generate, contact_email: "teste@gmail.com")
        expect(second_law_firm).to_not be_valid
    end

    it 'is valid with a valid CNPJ format' do
        law_firm = LawFirm.new(name: 'Example Law Firm', cnpj: CNPJ.generate, contact_email: "teste@gmail.com")
        expect(law_firm).to be_valid
    end


    it 'is not valid with an invalid CNPJ format' do
        law_firm = LawFirm.new(name: 'Example Law Firm', cnpj: '12345678901234', contact_email: "teste@gmail.com")
        expect(law_firm).not_to be_valid
        expect(law_firm.errors[:cnpj]).to include("is not valid")
    end

    
    it 'is valid with a valid email format' do
        law_firm = LawFirm.new(name: 'Example Law Firm', cnpj: CNPJ.generate, contact_email: "teste@gmail.com")
        expect(law_firm).to be_valid
    end


    it 'is not valid with an invalid email format' do
        law_firm = LawFirm.new(name: 'Example Law Firm', cnpj: '12345678901234', contact_email: "123")
        expect(law_firm).not_to be_valid
        expect(law_firm.errors[:cnpj]).to include("is not valid")
    end

    it 'associates a user with the law firm' do
        user = User.new(email: "test@example.com", password: "password", role: "admin")
        law_firm = LawFirm.new(name: 'Example Law Firm', cnpj: CNPJ.generate, contact_email: "test@example.com")
        law_firm.save
        law_firm.update_user_association(user)
        expect(user.law_firm).to eq(law_firm)
    end
end
