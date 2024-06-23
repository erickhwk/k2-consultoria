require 'rails_helper'
require "cpf_cnpj"

RSpec.describe LawFirm, type: :model do
    before(:each) do
        LawFirm.destroy_all
    end

    it "is valid with valid attributes" do
        law_firm = LawFirm.new(name: "Example Law Firm", cnpj: CNPJ.generate)
        expect(law_firm).to be_valid
    end

    it "is not valid without a name" do
        law_firm = LawFirm.new(cnpj: "12345678901234")
        expect(law_firm).to_not be_valid
    end

    it "is not valid without a cnpj" do
        law_firm = LawFirm.new(name: "Example Law Firm")
        expect(law_firm).to_not be_valid
    end

    it "is not valid with more than one registered law firm" do
        first_law_firm = LawFirm.new(name: "Example Law Firm", cnpj: "12345678901234")
        first_law_firm.save
        second_law_firm = LawFirm.new(name: "Example Law Firm", cnpj: "12345678901234")
        expect(second_law_firm).to_not be_valid
    end

    it 'is valid with a valid CNPJ format' do
        law_firm = LawFirm.new(name: 'Example Law Firm', cnpj: CNPJ.generate)
        expect(law_firm).to be_valid
    end


    it 'is not valid with an invalid CNPJ format' do
        law_firm = LawFirm.new(name: 'Example Law Firm', cnpj: '12345678901234')
        expect(law_firm).not_to be_valid
        expect(law_firm.errors[:cnpj]).to include("is not valid")
    end
end
