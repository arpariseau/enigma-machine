require_relative 'test_helper'
require './lib/bombe'
require 'date'

class BombeTest < Minitest::Test

  def setup
    @bombe = Bombe.new
  end

  def test_existence
    assert_instance_of Bombe, @bombe
  end
  
end
