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

  def test_find_shifts
    assert_equal [1, 23, 14, 24], @bombe.find_shifts("aaaa")
    assert_equal [26, 21, 12, 22], @bombe.find_shifts("zzzz")
    assert_equal [8, 14, 5, 5], @bombe.find_shifts("hssi")
  end

  def test_adjust_shifts
    assert_equal [5, 10, 15, 20], @bombe.adjust_shifts([5, -17, 15, -7])
  end

end
