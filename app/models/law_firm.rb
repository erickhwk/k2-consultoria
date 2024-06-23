require "cpf_cnpj"

class LawFirm < ApplicationRecord
    validates :name, :cnpj, presence: true
    validate :there_can_only_be_one
    validate :valid_cnpj

    
    private
    
    def valid_cnpj
        return if cnpj.blank?
    
        cnpj_digits = cnpj.gsub(/[^\d]/, '')
    
        unless CNPJ.valid?(cnpj_digits)
          errors.add(:cnpj, "is not valid")
        end
      end

    def there_can_only_be_one
        if LawFirm.count > 0
            errors.add(:base, "There can only be one law firm record")
        end
    end

end
