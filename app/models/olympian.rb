class Olympian < ApplicationRecord
  include ActiveModel::Serialization
  validates_presence_of :name, :sex, :age, :height, :weight
  belongs_to :team
  belongs_to :sport
  has_many :olympian_events
  has_many :events, through: :olympian_events
  enum sex: [:M, :F]

  def self.get_by_age_class(range)
    range == 'oldest' ? order(age: :desc).limit(1) : order(age: :asc).limit(1)
  end

  def total_medals_won
    olympian_events.where("medal != 0").length
  end

  def team_name
    team.name
  end

  def sport_name
    sport.name
  end

  def self.age_by_sex(sex)
    where(sex: sex).average(:weight).round(1).to_f
  end

  def self.average_age
    average(:age).round(1).to_f
  end

  def medal(event_id)
    olympian_events.find_by(event_id: event_id).medal
  end
end
