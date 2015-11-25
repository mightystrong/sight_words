class GamesController < ApplicationController
  before_action :set_points

  def random_words
    @word = Word.difficulty_set(SIGHT_WORDS, 1, "higher").sample
  end

  def list
    @list_name = params[:list].to_s.upcase
    @list = Kernel.const_get @list_name
    @words = Word.difficulty_set(@list, 6, "lower")
    @word = @words.sample
  end

  def hard_words
    @list_name = params[:list].to_s.upcase
    @list = Kernel.const_get @list_name
    @words = Word.difficulty_set(@list, 4)
    @word = @words.sample
  end

  def practice
    @list_name = params[:list].to_s.upcase
    @list = Kernel.const_get @list_name
    @words = Word.difficulty_set(@list, 6, "lower")
    @word = @words.sample
  end

  private
    def set_points
      @total_points = Point.total_points
      @todays_points = Point.todays_points
    end
end
