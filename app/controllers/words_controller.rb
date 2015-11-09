class WordsController < ApplicationController
  before_action :set_word, only: [:show, :edit, :update]

  respond_to :html

  def index
    @words = Word.all.sort { |x, y| x.name <=> y.name }
  end

  def show
    respond_with(@word)
  end

  def new
    @word = Word.new
    respond_with(@word)
  end

  def create
    @word = Word.new(word_params)
    if @word.save
      flash[:notice] = "Your word has been created."
      respond_with(@word)
    else
      flash.now[:error] = "There was an error creating your word. Please try again."
      render :new
    end
  end

  def edit
    respond_with(@word)
  end

  def update
    if @word.update_attributes(word_params)
      flash[:notice] = "Your word has been updated!"
      respond_with(@word)
    else
      flash.now[:error] = "There was an error updating your word. Please try again."
      render :edit
    end
  end

  private
    def set_word
      @word = Word.find(params[:id])
    end

    def word_params
      params.require(:word).permit(:name)
    end
end
