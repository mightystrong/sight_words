class GamesController < ApplicationController

  def random_words
    @word = Word.list_remaining(SIGHT_WORDS).sample
    @total_points = Point.total_points
    @todays_points = Point.todays_points
  end

  # For
  def list_one
    @word = Word.list_remaining(LIST_ONE).sample
    @total_points = Point.total_points
    @todays_points = Point.todays_points
  end

  def list_two
    @word = Word.list_remaining(LIST_TWO).sample
    @total_points = Point.total_points
    @todays_points = Point.todays_points
  end

  def list_three
    @word = Word.list_remaining(LIST_THREE).sample
    @total_points = Point.total_points
    @todays_points = Point.todays_points
  end
end
