require_relative 'add_lib'
require 'dohroot/pkg'
require 'minitest/autorun'

module Doh

class Test_pkg < MiniTest::Unit::TestCase
  def test_use_more_than_once
    Doh.root = File.join(__dir__, 'fake_pkg_root')
    assert(Doh.use_pkg(:none, 'some'))
    assert(!Doh.use_pkg(:none, 'some'))
  end
end

end
