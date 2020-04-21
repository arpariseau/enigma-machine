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

end
