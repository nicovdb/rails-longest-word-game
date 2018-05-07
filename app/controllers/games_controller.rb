require 'json'
require 'open-uri'

class GamesController < ActionController::Base
  def new
    alphabet = ('a'..'z').to_a
    @letters = alphabet.sample(8)
  end

  def score
    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    word_infos = open(url).read
    word = JSON.parse(word_infos)
    @length = word["length"].to_s

    new_word_array = params[:word].split("")
    initial_word_array = params[:letters].split("")


    if !new_word_array.all? do |letter|
      new_word_array.count(letter) <= initial_word_array.count(letter)
      end
      @answer = "#{word["word"]} cannot be made from the sample"
    else
      if word["found"]
        @answer = "#{word["word"]} is an english word and contains #{@length} characters"
      else
        @answer = "#{word["word"]} is not an english word"
      end
    end
  end
end


