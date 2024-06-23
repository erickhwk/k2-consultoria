class CreateLawFirms < ActiveRecord::Migration[7.0]
  def change
    create_table :law_firms do |t|
      t.string :name, null: false
      t.string :cnpj, null: false
      t.string :contact_email
      t.string :address_street
      t.string :address_complement
      t.string :address_city
      t.string :address_state
      t.string :address_zip_code
      t.string :address_country
      t.string :logo

      t.timestamps
    end
  end
end
