require_relative 'test_helper'
require './lib/enigma'
require 'date'

class EnigmaTest < Minitest::Test

  def setup
    @enigma = Enigma.new
  end

  def test_existence
    assert_instance_of Enigma, @enigma
  end

  def test_encrypt_w_key_date
    expected = {encryption: "keder ohulw", key: "02715", date: "040895"}
    assert_equal expected, @enigma.encrypt("hello world", "02715", "040895")
  end

  def test_encrypt_w_key
    Date.stubs(:today).returns(Date.new(1995, 8, 4))
    expected = {encryption: "keder ohulw", key: "02715", date: "040895"}
    assert_equal expected, @enigma.encrypt("hello world", "02715")
  end

  def test_encrypt
    Date.stubs(:today).returns(Date.new(1995, 8, 4))
    @enigma.stubs(:generate_random_key).returns("02715")
    expected = {encryption: "keder ohulw", key: "02715", date: "040895"}
    assert_equal expected, @enigma.encrypt("hello world")
  end

  def test_decrypt_w_date
    expected = { decryption: "hello world", key: "02715", date: "040895"}
    assert_equal expected, @enigma.decrypt("keder ohulw", "02715", "040895")
  end

  def test_decrypt
    Date.stubs(:today).returns(Date.new(1995, 8, 4))
    expected = { decryption: "hello world", key: "02715", date: "040895"}
    assert_equal expected, @enigma.decrypt("keder ohulw", "02715")
  end

  def test_crack_w_date
    expected = {decryption: "hello world end", date: "291018", key: "08304"}
    assert_equal expected, @enigma.crack("vjqtbeaweqihssi", "291018")
  end

  def test_split_message
    assert_equal ["Hoo", "e,r", "l l", "lwd"], @enigma.split_message("Hello, world")
  end

  def test_create_shifts
    assert_equal [3, 27, 73, 20], @enigma.create_shifts("02715", "040895")
  end

  def test_assemble
    assert_equal "abcdefg", @enigma.assemble(["ae", "bf", "cg", "d"])
  end

  def test_get_date
    Date.stubs(:today).returns(Date.new(1995, 8, 4))
    assert_equal "040895", @enigma.get_date
  end

  def test_generate_random_key
    @enigma.stubs(:rand).returns(5)
    assert_equal "00005", @enigma.generate_random_key
    @enigma.stubs(:rand).returns(15)
    assert_equal "00015", @enigma.generate_random_key
    @enigma.stubs(:rand).returns(715)
    assert_equal "00715", @enigma.generate_random_key
    @enigma.stubs(:rand).returns(2715)
    assert_equal "02715", @enigma.generate_random_key
    @enigma.stubs(:rand).returns(99999)
    assert_equal "99999", @enigma.generate_random_key
  end

  def test_prep_ciphers
    expected = {"Hoo" => 3, "e,r" => 27, "l l" => 73, "lwd" => 20}
    assert_equal expected, @enigma.prep_ciphers("Hello, world", "02715", "040895")
  end

  def test_find_shifts
    assert_equal [1, 23, 14, 24], @enigma.find_shifts("aaaa")
    assert_equal [26, 21, 12, 22], @enigma.find_shifts("zzzz")
    assert_equal [8, 14, 5, 5], @enigma.find_shifts("hssi")
  end

  def test_adjust_shifts
    assert_equal [5, 10, 15, 20], @enigma.adjust_shifts([5, -17, 15, -7])
  end

  def test_find_shift_positions
    assert_equal [14, 5, 5, 8], @enigma.find_shift_positions("hello world end", [8, 14, 5, 5])
  end

  def test_subtract_offsets
    assert_equal [8, 2, 3, 4], @enigma.subtract_offsets([14, 5, 5, 8], "291018")
  end

  def test_break_code
    assert_equal "08304", @enigma.break_code([8, 2, 3, 4])
  end

  def test_get_possible_codes
    expected = [[8, 35, 62, 89], [2, 29, 56, 83],
                [3, 30, 57, 84], [4, 31, 58, 85]]
    assert_equal expected, @enigma.get_possible_codes([8, 2, 3, 4])
  end

  def test_construct_code_strings
    input = [[8, 35, 62, 89], [2, 29, 56, 83],
             [3, 30, 57, 84], [4, 31, 58, 85]]
    expected = [["08", "35", "62", "89"], ["02", "29", "56", "83"],
                ["03", "30", "57", "84"], ["04", "31", "58", "85"]]
    assert_equal expected, @enigma.construct_code_strings(input)
  end

   def test_find_matches
     input = [["08", "35", "62", "89"], ["02", "29", "56", "83"],
              ["03", "30", "57", "84"], ["04", "31", "58", "85"]]
     assert_equal ["08", "83", "30", "04"], @enigma.find_matches(input)
   end

end
