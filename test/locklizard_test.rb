#require "test_helper"
#require "locklizard"
require "minitest/autorun"

class LockLizardTest < Minitest::Test
  
  def test_that_it_has_a_version_number
    refute_nil ::LockLizard::VERSION
  end

  def test_it_does_something_useful
    assert false
  end

  def test_returns_valid_api_connection
    locklizard_connection = LockLizard.Api(ENN['LOCKLIZARD_API_URL'])
    assert locklizard_connection |= nil
  end

end
