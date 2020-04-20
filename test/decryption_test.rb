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

  def test_set_paths
    @decrypt.stubs(:get_paths).returns(["encrypted.txt", "decrypted.txt", "82648", "240818"])
    @decrypt.set_paths
    assert_equal "encrypted.txt", @decrypt.input_path
    assert_equal "decrypted.txt", @decrypt.output_path
    assert_equal "82648", @decrypt.keycode
    assert_equal "240818", @decrypt.date
  end

end
