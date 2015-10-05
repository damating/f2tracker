class Player < ActiveRecord::Base

  before_save { self.email = email.downcase }
  validates :first_name, presence: true, length: { maximum: 50 } 
  validates :last_name,  presence: true, length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
		    format: { with: VALID_EMAIL_REGEX },
		    uniqueness: { case_sensitive: false }

  has_secure_password

  has_many :matches
  validates :password, length: { minimum: 6 }, allow_blank: true

  has_attached_file :avatar
  validates_attachment_file_name :avatar, :matches => [/png\Z/, /jpe?g\Z/, /gif\Z/]

  def admin?
    self.role == 'admin'
  end

  def get_full_name
	"#{first_name} #{last_name}"
  end
end
