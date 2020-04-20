require_relative 'test_helper'
require './lib/decryption'

class DecryptionTest < Minitest::Test

  def setup
    @decrypt = Decryption.new
  end

  def test_existence
    assert_instance_of Decryption, @decrypt
  end

end
