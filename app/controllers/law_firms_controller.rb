class LawFirmsController < ApplicationController
  before_action :set_law_firm, only: [:show, :edit, :update]
  before_action :authenticate_user!


  def show
  end

  def new
    @law_firm = LawFirm.new
  end

  def create
    @law_firm = LawFirm.new(law_firm_params)
    if @law_firm.save
      @law_firm.update_user_association(current_user)
      redirect_to @law_firm, notice: 'Law Firm was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @law_firm.update(law_firm_params)
      redirect_to @law_firm, notice: 'Law Firm was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
  
  def set_law_firm
    @law_firm = LawFirm.find(params[:id])
  end

  def law_firm_params
    params.require(:law_firm).permit(:name,
                                     :cnpj,
                                     :contact_email,
                                     :address_street,
                                     :address_complement,
                                     :address_city,
                                     :address_state,
                                     :address_zip_code,
                                     :address_country,
                                     :logo
    )
  end
end
