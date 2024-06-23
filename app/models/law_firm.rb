class LawFirm < ApplicationRecord
    validates :name, :cnpj, presence: true
    validate :there_can_only_be_one

    private

    def there_can_only_be_one
        if LawFirm.count > 0
            errors.add(:base, "There can only be one law firm record")
        end
    end
end
