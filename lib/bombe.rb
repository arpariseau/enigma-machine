class Bombe

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
