require_relative 'cipher'
require 'date'

class Enigma < Cipher

  def encrypt(message, keycode=nil, date=nil)
    date = get_date if date == nil
    keycode = generate_random_key if keycode == nil
    ciphers = prep_ciphers(message, keycode, date)
    encoded = []
    ciphers.each {|message, shift| encoded << encode(message, shift)}
    {encryption: assemble(encoded), key: keycode, date: date}
  end

  def decrypt(message, keycode, date=nil)
    date = get_date if date == nil
    ciphers = prep_ciphers(message, keycode, date)
    decoded = []
    ciphers.each {|message, shift| decoded << decode(message, shift)}
    {decryption: assemble(decoded), key: keycode, date: date}
  end

  def crack(message, date=nil)
    date = get_date if date == nil
    crib_word = message[-4..-1]
    base_shifts = find_shifts(crib_word)
    shifts = find_shift_positions(message, base_shifts)
    code_shifts = subtract_offsets(shifts, date)
    keycode = break_code(code_shifts)
    decrypt(message, keycode, date)
  end

  def prep_ciphers(message, keycode, date)
    splits = split_message(message)
    shifts = create_shifts(keycode, date)
    Hash[splits.zip shifts]
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

  def assemble(scrambled)
    finished = []
    (0..scrambled.first.length).to_a.each do |index|
      scrambled.each {|snippet| finished << snippet[index] if
                              !snippet[index].nil?}
    end
    finished.join
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

  def find_shifts(crib_word)
    letters = ("a".."z").to_a << " "
    numbers = (1..27).to_a
    shift_finder = Hash[letters.zip numbers]
    shifts = []
    shifts << shift_finder[crib_word.chars[0]]
    shifts << shift_finder[crib_word.chars[1]] - 5
    shifts << shift_finder[crib_word.chars[2]] - 14
    shifts << shift_finder[crib_word.chars[3]] - 4
    adjust_shifts(shifts)
  end

  def adjust_shifts(shifts)
    shifts.map do |shift|
      if shift.negative?
        shift += 27
      else
        shift
      end
    end
  end

  def find_shift_positions(message, shifts)
    shift_pos = message.length % 4
    pos_swap = shifts.shift(4 - shift_pos)
    shifts += pos_swap
  end

  def subtract_offsets(shifts, date)
    date_squared = (date.to_i ** 2).to_s[-4..-1]
    index = -1
    shifts.map do |shift|
      index += 1
      shift -= date_squared.chars[index].to_i
    end
  end

  def break_code(code_shifts)
     possible_codes = get_possible_codes(code_shifts)
     code_strings = construct_code_strings(possible_codes)
     matches = find_matches(code_strings)
     matches[0][0] + matches[1][0] + matches[2][0] + matches[3]
  end

  def get_possible_codes(code_shifts)
    code_shifts.map do |shift|
      (0..99).to_a.find_all{|num| num % 27 == shift}
    end
  end

  def construct_code_strings(possible_codes)
    possible_codes.map do |codes|
      codes.map do |code|
        if code <= 9
          code = "0" + code.to_s
        else
          code.to_s
        end
      end
    end
  end

  def find_matches(code_strings)
    code_strings[0].each do |code1|
      second_code = code_strings[1].find {|code2| code1[1] == code2[0]}
      next if second_code.nil?
      third_code = code_strings[2].find {|code3| second_code[1] == code3[0]}
      next if third_code.nil?
      final_code = code_strings[3].find {|code4| third_code[1] == code4[0]}
      next if final_code.nil?
      return [code1, second_code, third_code, final_code]
    end
  end

end
