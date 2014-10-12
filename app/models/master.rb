class Master < ActiveRecord::Base
  has_secure_password

  has_many :events
  validates_uniqueness_of :name
  validates_uniqueness_of :email
  validates :password, confirmation: true,
    length: { within: 4..30 }, presence: true,
    if: :password_required?
  scope :active, lambda { where("active = 't'") }

  protected
    def password_required?
      password_digest.blank? || password.present?
    end
end
