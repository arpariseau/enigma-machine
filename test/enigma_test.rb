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

  def test_attributes
    assert_equal ({}), @enigma.cipher_a
    assert_equal ({}), @enigma.cipher_b
    assert_equal ({}), @enigma.cipher_c
    assert_equal ({}), @enigma.cipher_d
  end

  def test_encrypt
    skip
    expected = {encryption: "keder ohulw", key: "02715", date: "040895"}
    assert_equal expected, @enigma.encrypt("hello world", "02715", "040895")
  end

  def test_split_message
    assert_equal ["Hoo", "e,r", "l l", "lwd"], @enigma.split_message("Hello, world")
  end

  def test_create_shifts
    assert_equal [3, 27, 73, 20], @enigma.create_shifts("02715", "040895")
  end

  def test_create_offsets
    assert_equal [3, 27, 73, 20], @enigma.create_offsets([02, 27, 71, 15], "040895")
  end

end
