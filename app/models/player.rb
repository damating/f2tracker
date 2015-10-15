class Player < ActiveRecord::Base

  scope :desc, -> { order("players.won_matches DESC") }

  before_save { self.email = email.downcase }
  validates :first_name, presence: true, length: { maximum: 50 } 
  validates :last_name,  presence: true, length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
		    format: { with: VALID_EMAIL_REGEX },
		    uniqueness: { case_sensitive: false }

  has_secure_password

  has_many :matches, dependent: :destroy
  validates :password, length: { minimum: 6 }, allow_blank: true

  has_attached_file :avatar
  validates_attachment_file_name :avatar, :matches => [/png\Z/, /jpe?g\Z/, /gif\Z/]

  def admin?
    self.role == 'admin'
  end

  def get_full_name
	"#{first_name} #{last_name}"
  end

  def matches
    Match.get_matches_by_person(self.id)
  end

  def played_matches
    self.matches.count
  end

  def won_matches
    Match.get_won_matches(self.id).count
  end

  def lost_matches
    Match.get_lost_matches(self.id).count
  end

  def get_points
    self.won_matches * 3 - self.lost_matches
  end

  def all_goals
    Match.goals_number(self.id)
  end

  def average_goals_per_game
    if !(matches.empty?)
      (all_goals/played_matches).to_f
    else
      return 0
    end
  end

  def self.sort_by_wins
    all.sort_by('&:won_matches DESC' )
  end

end
