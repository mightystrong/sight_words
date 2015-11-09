class Point
  include Mongoid::Document
  include Mongoid::Timestamps

  field :value,   type: Integer, default: -> { 0 }

  validates :word_id, :value, presence: true

  belongs_to :word

  def self.test_words(words)
    words
  end

  def self.total_points
    points = self.pluck(:value)
    sum = 0
    points.each do |v|
      sum += v
    end
    sum
  end

  def self.todays_points
    points = self.where(:created_at.gt => Time.zone.now.beginning_of_day).pluck(:value)
    sum = 0
    points.each do |v|
      sum += v
    end
    sum
  end
end
