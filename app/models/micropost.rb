class Micropost < ActiveRecord::Base
  belongs_to :station
  default_scope -> { order(created_at: :desc) }
  validates :station_id, presence: true
  validates :team_id, presence: true
  validates :points, presence: true, length: { maximum: 140 }
end