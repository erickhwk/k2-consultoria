class User < ApplicationRecord
  belongs_to :law_firm, optional: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { admin: 'admin', manager: 'manager' }

  validates :email, presence: true, email: true
  validates :password, presence: true
  validates :role, presence: true, inclusion: { in: roles.keys }
end
