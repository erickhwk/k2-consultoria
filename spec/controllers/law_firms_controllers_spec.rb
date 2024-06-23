require 'rails_helper'
require 'cpf_cnpj'

RSpec.describe "LawFirms", type: :request do
  let(:user) { User.create(email: 'test@example.com', password: 'password', role: 'admin')}
  let(:valid_attributes) do
    {
      name: 'Test Law Firm',
      cnpj: CNPJ.generate,
      contact_email: 'test@example.com'
    }
  end
  let(:law_firm) { LawFirm.create(valid_attributes) }
  
  before do
    sign_in user
  end

  describe "GET /show" do
    it "returns http success" do
      get law_firm_path(law_firm)
      expect(response).to have_http_status(:success)
    end
  end
  
  describe "GET /new" do
    it "returns http success" do
      get new_law_firm_path
      expect(response).to have_http_status(:success)
    end
  end
  
  describe "POST /create" do
    context 'with valid params' do
      it "returns http success" do
        post law_firms_path, params: { law_firm: valid_attributes }
        expect(response).to have_http_status(:redirect)
      end

      it 'associates the law firm with the current user' do
        post law_firms_path, params: { law_firm: valid_attributes }
        law_firm = LawFirm.last
        expect(law_firm.users.first).to eq(user)
      end
    end

    context 'with invalid params' do
      it "returns http success" do
        post law_firms_path, params: { law_firm: { name: '' } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get edit_law_firm_path(law_firm)
      expect(response).to have_http_status(:success)
    end
  end
  
  describe "PATCH /update" do
    context 'with valid params' do
      let(:new_attributes) do
        {
          name: 'Updated Law Firm',
          contact_email: 'updated@example.com'
        }
      end

      it "updates the requested law_firm and returns http redirect" do
        patch law_firm_path(law_firm), params: { law_firm: new_attributes }
        law_firm.reload
        expect(law_firm.name).to eq('Updated Law Firm')
        expect(law_firm.contact_email).to eq('updated@example.com')
        expect(response).to have_http_status(:redirect)
      end
    end

    context 'with invalid params' do
      it "does not update the law_firm and returns http unprocessable_entity" do
        patch law_firm_path(law_firm), params: { law_firm: { name: '' } }
        law_firm.reload
        expect(law_firm.name).to eq('Test Law Firm')
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end