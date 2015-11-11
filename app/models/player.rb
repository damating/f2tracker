class Player < ActiveRecord::Base


  has_many :matches
  belongs_to :badge
  before_create :set_player

  validates :first_name, presence: true, length: {maximum: 20}, format: {with: /\A[a-zA-Z0-9_\-]+\z/,
                                                                         message: "Must be formatted correctly"}
  validates :last_name, presence: true, length: {maximum: 30}, format: {with: /\A[a-zA-Z0-9_\-]+\z/,
                                                                        message: "Must be formatted correctly"}


  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255},
            format: {with: VALID_EMAIL_REGEX},
            uniqueness: {case_sensitive: false}

  has_secure_password
  validates :password, presence: true, confirmation: true, length: {minimum: 6}, on: create

  has_attached_file :avatar
  validates_attachment_file_name :avatar, :matches => [/png\Z/, /jpe?g\Z/, /gif\Z/]

  def set_player
    self.email = email.downcase
    self.wins = 0
    self.losts = 0
    self.points = 0
    self.goals = 0
    self.badge_id = 6
    # self.role = 'player'
  end

  def Player.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
        BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def admin?
    self.role == 'admin'
  end

  def get_full_name
    "#{first_name} #{last_name}"
  end

  def self.search(search)
    if search
      search.downcase!
      if search == 'admin' || search == 'player'
        where('LOWER(role) LIKE ?', "%#{search}%")
      elsif search.include?('@')
        where('LOWER(email) LIKE ?', "%#{search}%")
      else
        where('LOWER(last_name) LIKE ?', "%#{search}%")
      end
    else
      all.reverse
    end
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
