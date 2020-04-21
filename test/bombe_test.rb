require_relative 'test_helper'
require './lib/bombe'
require 'date'

class BombeTest < Minitest::Test

  def setup
    @bombe = Bombe.new
  end

  def test_existence
    assert_instance_of Bombe, @bombe
  end

  def test_find_shifts
    assert_equal [1, 23, 14, 24], @bombe.find_shifts("aaaa")
    assert_equal [26, 21, 12, 22], @bombe.find_shifts("zzzz")
    assert_equal [8, 14, 5, 5], @bombe.find_shifts("hssi")
  end

  def test_adjust_shifts
    assert_equal [5, 10, 15, 20], @bombe.adjust_shifts([5, -17, 15, -7])
  end

  def test_find_shift_positions
    assert_equal [14, 5, 5, 8], @bombe.find_shift_positions("hello world end", [8, 14, 5, 5])
  end

  def test_subtract_offsets
    assert_equal [8, 2, 3, 4], @bombe.subtract_offsets([14, 5, 5, 8], "291018")
  end

  def test_break_code
    assert_equal "08304", @bombe.break_code([8, 2, 3, 4])
  end

  def test_get_possible_codes
    expected = [[8, 35, 62, 89], [2, 29, 56, 83],
                [3, 30, 57, 84], [4, 31, 58, 85]]
    assert_equal expected, @bombe.get_possible_codes([8, 2, 3, 4])
  end

  def test_construct_code_strings
    input = [[8, 35, 62, 89], [2, 29, 56, 83],
             [3, 30, 57, 84], [4, 31, 58, 85]]
    expected = [["08", "35", "62", "89"], ["02", "29", "56", "83"],
                ["03", "30", "57", "84"], ["04", "31", "58", "85"]]
    assert_equal expected, @bombe.construct_code_strings(input)
  end

   def test_find_matches
     input = [["08", "35", "62", "89"], ["02", "29", "56", "83"],
              ["03", "30", "57", "84"], ["04", "31", "58", "85"]]
     assert_equal ["08", "83", "30", "04"], @bombe.find_matches(input)
   end

end
