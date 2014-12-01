class Master < ActiveRecord::Base
  has_secure_password

  has_many :events
  validates_uniqueness_of :name
  validates_presence_of :name, message: "マスター名は必須です。"
  validates_uniqueness_of :email, message: "このアドレスは既に登録されています。"
  validates_presence_of :email, message: "メールアドレスは必須です。"
  validates :password, confirmation: true,
    length: { within: 4..30 }, presence: true,
    if: :password_required?
  validates :url, format: {with: URI.regexp,    message: "URLが正しくありません。"},
    if: lambda{ |m| m.url.present? }
  
   
  scope :active, lambda { where("active = true") }
  
  def password=(password_raw)
    if password_raw.kind_of?(String)
      self.password_digest = BCrypt::Password.create(password_raw)
    elsif password_raw.nil?
      self.password_digest = nil
    end
  end

  protected
    def password_required?
      password_digest.blank? || password.present?
    end
end
