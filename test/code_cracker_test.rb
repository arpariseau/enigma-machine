require_relative 'test_helper'
require './lib/code_cracker'

class CodeCrackerTest < Minitest::Test

  def setup
    @crack = CodeCracker.new
  end

  def test_existence
    assert_instance_of CodeCracker, @crack
  end
  
end
