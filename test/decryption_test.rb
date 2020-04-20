require_relative 'test_helper'
require './lib/decryption'

class DecryptionTest < Minitest::Test

  def setup
    @decrypt = Decryption.new
  end

  def test_existence
    assert_instance_of Decryption, @decrypt
  end

  def test_attributes
    assert_equal "", @decrypt.input_path
    assert_equal "", @decrypt.output_path
    assert_equal "", @decrypt.keycode
    assert_equal "", @decrypt.date
  end

end
