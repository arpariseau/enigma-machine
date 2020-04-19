class Cipher
  attr_reader :cipher

  def initialize
    @cipher = {}
  end

  def encode(message, shift)
    create_cipher(shift)
    message.downcase.chars.map do |letter|
      if @cipher.include?(letter)
        @cipher[letter]
      else
        letter
      end
    end.join
  end

  def create_cipher(shift)
    shift -= 27 until shift <= 27
    base = ("a".."z").to_a << " "
    shifted = base.dup
    shifting = shifted.shift(shift)
    shifted += shifting
    @cipher = Hash[base.zip shifted]
  end

end
