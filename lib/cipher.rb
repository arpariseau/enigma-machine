class Cipher
  attr_reader :cipher

  def initialize
    @cipher = {}
  end

  def encode(message, shift)
    create_cipher(shift)
    message.downcase.chars.map {|letter| @cipher[letter]}.join
  end

end
