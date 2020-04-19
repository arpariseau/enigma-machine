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

end
