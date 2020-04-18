class Enigma
  attr_reader :cipher_a, :cipher_b, :cipher_c, :cipher_d

  def initialize
    @cipher_a = []
    @cipher_b = []
    @cipher_c = []
    @cipher_d = []
  end

  def encrypt(message, keycode, date)
    split_message(message)
    #create the offsets
    #adjust the messages
    #concatenate
  end

  def split_message(message)
    message.chars.each_slice(4) do |fourletter|
      @cipher_a << fourletter[0]
      @cipher_b << fourletter[1]
      @cipher_c << fourletter[2]
      @cipher_d << fourletter[3]
    end
  end

end
