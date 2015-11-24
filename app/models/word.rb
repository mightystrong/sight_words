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

  # Returns a lambda used to determine what number is at t in the range of a and b
  #
  #   interpolate_number(0, 500).call(0.5) # 250
  #   interpolate_number(0, 500).call(1) # 500
  #
  def interpolate(a, b)
    a = a.to_f
    b = b.to_f
    b -= a

    lambda { |t| a + b * t }
  end

  # Returns a lambda used to determine where t lies between a and b with an ouput
  # range of 0 and 1
  #
  #   uninterpolate_number(0, 500).call(0)   # 0
  #   uninterpolate_number(0, 500).call(250) # 0.5
  #   uninterpolate_number(0, 500).call(500) # 1.0
  #
  def uninterpolate
    a = 0.0
    b = (wrong + right).to_f
    b = b - a > 0 ? 1 / (b - a) : 0

    lambda { |x| (x - a) * b }
  end

  # Returns a closure with the specified input domain and output range
  #
  #   score = scale([0, 500], [0, 1.0])
  #
  #   score.call(0) = 0
  #   score.call(250) = 0.5
  #   score.call(500) = 1.0
  #
  #
  # domain - Array. Input domain
  # range  - Array. Output range
  #
  # Returns lambda
  def scale(range)
    u = uninterpolate
    i = interpolate(range[0], range[1])

    lambda do |x|
      x = ([0.0, x, (wrong + right).to_f].sort[1]).to_f
      i.call(u.call(x))
    end
  end

  def difficulty(scale=[1.0, 10.0])
    scale(scale).call(wrong)
  end

  def self.difficulty_set(list, score=0.0, direction="higher")
    words = []
    where(:name.in => list).each do |w|
      if direction == "higher"
        words << w if w.difficulty >= score.to_f
      else
        words << w if w.difficulty <= score.to_f
      end
    end
    words
  end
end
