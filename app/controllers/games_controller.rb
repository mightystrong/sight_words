class GamesController < ApplicationController

  def random_word
    @word = Word.all.sample
    @total_points = Point.total_points
    @todays_points = Point.todays_points
  end
end
