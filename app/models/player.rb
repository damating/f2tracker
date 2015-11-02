class Player < ActiveRecord::Base

  has_many :matches#, dependent: :destroy
  belongs_to :badge
  before_save :set_player

  #validates_presence_of :first_name, :last_name, :email

  validates :first_name, presence: true, length: { maximum: 20 }, format: { with: /\A[a-zA-Z0-9_\-]+\z/,
                                                                            message: "must be formatted correctly." }
  validates :last_name,  presence: true, length: { maximum: 30 }, format: { with: /\A[a-zA-Z0-9_\-]+\z/,
                                                                            message: "must be formatted correctly." }

  #validates_format_of :first_name, :with => /\A[^0-9`!@#\$%\^&*+_=]+\z/, message: "ddada"
  #validates_format_of :first_name, :last_name, :with => /\A([^\d\W]|[-])*\z/, :allow_blank => true, :message => "ssss"

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
		    format: { with: VALID_EMAIL_REGEX },
		    uniqueness: { case_sensitive: false }

  has_secure_password
  #validates_presence_of :password, :on => create
  validates :password, length: { minimum: 6 }, allow_blank: true, on: create

  has_attached_file :avatar
  validates_attachment_file_name :avatar, :matches => [/png\Z/, /jpe?g\Z/, /gif\Z/]





  def set_player
    self.email = email.downcase
    self.wins = 0
    self.losts = 0
    self.points = 0
    self.goals = 0
  end

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

  #def get_points
   # self.won_matches * 3 - self.lost_matches
  #end

  def get_points
    self.wins * 3 - self.losts
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

end
