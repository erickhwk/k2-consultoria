class User < ApplicationRecord
  belongs_to :law_firm, optional: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         belongs_to :law_firm, optional: true
         
  enum role: { admin: 'admin', lawyer: 'lawyer' }
  
  validates :role, presence: true, inclusion: { in: roles.keys }
end
