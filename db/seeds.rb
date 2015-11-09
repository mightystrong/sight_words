# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if Rails.env.development? || Rails.env.test?
  Point.destroy_all
  Word.destroy_all

  SIGHT_WORDS.each do |w|
    Word.create(name: w)
  end
end

if Rails.env.production?
  SIGHT_WORDS.each do |w|
    Word.create(name: w)
  end
end
