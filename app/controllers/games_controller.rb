require "open-uri"

class GamesController < ApplicationController

  #   A page to display the game settings (random letters), with a form for the user to type a word. A button to submit this form.
  #   A page receiving this form, computing the user score and displaying it.
  def new
    vowels = %w[A E I O U]
    @letters = (Array.new(7) { ("A".."Z").to_a.sample } + Array.new(3) { vowels.sample }).shuffle
  end

  def score
    session[:grand_score] ||= 0
    @word = params[:word].upcase
    array = params[:letters_array].chars
    # check if all letters are in original array
    if check_letters(@word, array)
      # check if word
      data = JSON.parse(URI.open("https://wagon-dictionary.herokuapp.com/#{@word}").read)
      if data["found"]
        @message = "congrats"
        @score = @word.length
        session[:grand_score] += @word.length
        @total = session[:grand_score]
      else
        @message = "not a word sorry"
      end
        # @message = data["found"] ? "congrats" : "not a word sorry"
    else
      @message = "you cant build that"
    end
  end

  private

  def check_letters(word, array)
    word.chars.all? { |letter| word.count(letter) <= array.count(letter) }
  end
end
