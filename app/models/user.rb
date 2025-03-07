class User < ApplicationRecord
  has_secure_password
  
  has_many :forms, dependent: :destroy
  has_many :form_submissions
  
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :name, presence: true
  validates :role, inclusion: { in: %w(admin provider patient) }
  validates :preferred_language, presence: true
  
  def admin?
    role == 'admin'
  end
  
  def provider?
    role == 'provider' || role == 'admin'
  end
  
  def patient?
    role == 'patient'
  end
end 