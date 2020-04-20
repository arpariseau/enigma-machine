require_relative 'test_helper'
require './lib/bombe'
require 'date'

class BombeTest < Minitest::Test

  def setup
    @bombe = Bombe.new("vjqtbeaweqihssi", "291018")
  end

  def test_existence
    assert_instance_of Bombe, @bombe
  end

  def test_attributes
    assert_equal "vjqtbeaweqihssi", @bombe.message
    assert_equal "291018", @bombe.date
  end

end
