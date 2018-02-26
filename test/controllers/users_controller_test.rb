require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test "should get index" do
    get welcome_index_path
    assert_response :success
    assert_select "title","Home-page| Breay-crm"
    end
end
