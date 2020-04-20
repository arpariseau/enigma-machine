require_relative 'cipher'
require 'date'

class Enigma < Cipher

  def encrypt(message, keycode=nil, date=nil)
    date = get_date if date == nil
    keycode = generate_random_key if keycode == nil
    splits = split_message(message)
    shifts = create_shifts(keycode, date)
    ciphers = Hash[splits.zip shifts]
    encoded = []
    ciphers.each {|message, shift| encoded << encode(message, shift)}
    {encryption: assemble(encoded), key: keycode, date: date}
  end

  def decrypt(message, keycode, date)
    splits = split_message(message)
    shifts = create_shifts(keycode, date)
    ciphers = Hash[splits.zip shifts]
    decoded = []
    ciphers.each {|message, shift| decoded << decode(message, shift)}
    {decryption: assemble(decoded), key: keycode, date: date}
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
    date_squared = (date.to_i ** 2).to_s[-4..-1]
    i = -1
    keyshifts.map do |keyshift|
      i += 1
      keyshift += date_squared[i].to_i
    end
  end

  def assemble(encoded)
    encrypted = []
    (0..encoded.first.length).to_a.each do |index|
      encoded.each {|snippet| encrypted << snippet[index] if
                              !snippet[index].nil?}
    end
    encrypted.join
  end

  def get_date
    Date.today.strftime("%d%m%y")
  end

  def generate_random_key
    random_key = rand(100000)
    return "0000" + random_key.to_s if random_key < 10
    return "000" + random_key.to_s if random_key < 100
    return "00" + random_key.to_s if random_key < 1000
    return "0" + random_key.to_s if random_key < 10000
    random_key.to_s
  end

end
