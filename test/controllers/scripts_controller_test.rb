require 'test_helper'

class ScriptsControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get scripts_edit_url
    assert_response :success
  end

  test "should get update" do
    get scripts_update_url
    assert_response :success
  end

end
