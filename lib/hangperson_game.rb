class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  attr_reader :word, :guesses, :wrong_guesses
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end
  
  def guess char
    raise ArgumentError unless /^[a-z]$/i =~ char
    if @word.downcase.include? char.downcase 
      append @guesses, char
    else
      append @wrong_guesses, char
      
    end
  end 
  def word_with_guesses
    @word.gsub(Regexp.new("[^-#{@guesses}]", 'i'), '-')
  end
  
  def check_win_or_lose
    return :win if @word == word_with_guesses
    return :lose if @wrong_guesses.length == 7
    :play
  end
  
  def append string, char
    if string.downcase.include? char.downcase  
      false
    else
      string << char
    end 
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end