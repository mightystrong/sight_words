class Word
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name

  validates :name, presence: true
  validates :name, uniqueness: true

  index({ name: 1 }, { unique: true, name: "name_index" })

  before_save :downcase_name

  has_many :points, dependent: :restrict

  def downcase_name
    self.name = self.name.downcase
  end

  def right
    self.points.where(value: 1).count
  end

  def wrong
    self.points.where(value: 0).count
  end

  def self.remaining
    words = Word.all
    words.reject { |x| x.right >= 5 }
  end
end
