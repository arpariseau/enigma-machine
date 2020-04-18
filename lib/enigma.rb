class Enigma
  attr_reader :cipher_a, :cipher_b, :cipher_c, :cipher_d

  def initialize
    @cipher_a = Hash.new(0)
    @cipher_b = Hash.new(0)
    @cipher_c = Hash.new(0)
    @cipher_d = Hash.new(0)
  end

  def encrypt(message, keycode, date)
    messages = split_message(message)
    offsets = create_shifts(keycode, date)
    create_ciphers(messages, offsets)
    #adjust the messages
    #concatenate
  end

  def split_message(message)
    msg_a, msg_b, msg_c, msg_d = [], [], [], []
    message.chars.each_slice(4) do |fourletter|
      msg_a << fourletter[0]; msg_b << fourletter[1]
      msg_c << fourletter[2]; msg_d << fourletter[3]
    end
    [msg_a.join, msg_b.join,msg_c.join, msg_d.join]
  end

  def create_shifts(keycode, date)
    keyshifts = [keycode[0..1].to_i, keycode[1..2].to_i,
                 keycode[2..3].to_i, keycode[3..4].to_i]
    create_offsets(keyshifts, date)
  end

  def create_offsets(keyshifts, date)
    date_squared = (date.to_i ** 2).to_s[-4..-1]
    i = -1
    keyshifts.map do |keyshift|
      i += 1
      keyshift += date_squared[i].to_i
    end
  end

end
