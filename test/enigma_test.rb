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

end
