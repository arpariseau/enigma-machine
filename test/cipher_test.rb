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

end
