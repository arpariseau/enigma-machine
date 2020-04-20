require_relative 'test_helper'
require './lib/encrypt'

class EncryptTest < Minitest::Test

  def setup
    @encrypt = Encrypt.new
  end

  def test_existence
    assert_instance_of Encrypt, @encrypt
  end

  def test_attributes
    assert_equal "", @encrypt.input_path
    assert_equal "", @encrypt.output_path
  end

  def test_set_paths
    @encrypt.stubs(:get_paths).returns(["message.txt", "encrypted.txt"])
    @encrypt.set_paths
    assert_equal "message.txt", @encrypt.input_path
    assert_equal "encrypted.txt", @encrypt.output_path
  end

end
