require_relative 'test_helper'
require './lib/cipher'

class CipherTest < Minitest::Test

  def setup
    @cipher = Cipher.new
  end

  def test_existence
    assert_instance_of Cipher, @cipher
  end

  def test_attributes
    assert_equal ({}), @cipher.cipher
  end

  def test_encode
    assert_equal "kajr?", @cipher.encode("Duck?", 7)
  end

  def test_create_cipher
    expected = {"a" => "e", "b" => "f", "c" => "g",
                "d" => "h", "e" => "i", "f" => "j",
                "g" => "k", "h" => "l", "i" => "m",
                "j" => "n", "k" => "o", "l" => "p",
                "m" => "q", "n" => "r", "o" => "s",
                "p" => "t", "q" => "u", "r" => "v",
                "s" => "w", "t" => "x", "u" => "y",
                "v" => "z", "w" => " ", "x" => "a",
                "y" => "b", "z" => "c", " " => "d"}
    @cipher.create_cipher(31)
    assert_equal expected, @cipher.cipher
  end

end
