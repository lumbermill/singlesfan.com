require 'test_helper'

class MasterTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  test "password" do
    m = Master.new
    m.password = 'secret'
    assert m.password_digest.kind_of?(String)
    assert m.password_digest.size == 60
  end
end
