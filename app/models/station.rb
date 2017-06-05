class Station < ActiveRecord::Base
  has_many :microposts, dependent: :destroy
  has_many :rallys, dependent: :destroy
  has_many :teams, dependent: :destroy
  default_scope -> { order(name: :asc) }
  
  attr_accessor :remember_token
  validates :name,  presence: true, length: { maximum: 50 },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 4 }, allow_nil: true
  
  mount_uploader :picture, PictureUploader
  validate  :picture_size

 

  # Returns the hash digest of the given string.
  def Station.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def Station.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = Station.new_token
    update_attribute(:remember_digest, Station.digest(remember_token))
  end
  
  # Defines a proto-feed.
  # See "Following users" for the full implementation.
  def feed
    Micropost.where("station_id = ?", id)
  end

  # Returns true if the given token matches the digest.
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
  
  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end
  
  private

    # Validates the size of an uploaded picture.
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
  
end