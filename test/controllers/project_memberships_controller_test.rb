require 'test_helper'

class ProjectMembershipsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get project_memberships_create_url
    assert_response :success
  end

  test "should get edit" do
    get project_memberships_edit_url
    assert_response :success
  end

  test "should get update" do
    get project_memberships_update_url
    assert_response :success
  end

  test "should get destroy" do
    get project_memberships_destroy_url
    assert_response :success
  end

end
