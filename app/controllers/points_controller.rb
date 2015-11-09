class PointsController < ApplicationController

  def correct_answer
    @word = Word.find(params[:word_id])
    if @word
      @point = Point.new(value: 1, word_id: @word.id)
      if @point.save
        flash[:notice] = "Awesome job. You are correct!!"
        redirect_to :back
      else
        flash.now[:error] = "There was an error adding points. Please try again."
        redirect_to root_path
      end
    else
      flash.now[:error] = "You need to provide a word to get a correct answer."
      redirect_to root_path
    end
  end

  def wrong_answer
    @word = Word.find(params[:word_id])
    if @word
      @point = Point.new(value: 0, word: @word.id)
      if @point.save
        flash[:error] = "Sorry Layla. But the answer is wrong. Please try another word."
        redirect_to :back
      else
        flash.now[:error] = "There was an error adding points. Please try again."
        redirect_to root_path
      end
    else
      flash.now[:error] = "You need to provide a word to get a correct answer."
      redirect_to root_path
    end
  end

  private
    def set_point
      @point = Point.find(params[:id])
    end
    def point_params
      params.require(:point).permit(:value, :word_id)
    end
end
