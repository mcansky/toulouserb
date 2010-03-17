require 'test_helper'

class PartnerTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Partner.new.valid?
  end
end
