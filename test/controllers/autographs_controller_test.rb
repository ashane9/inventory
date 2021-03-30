require 'test_helper'

class AutographsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @autograph = autographs(:one)
  end

  test "should get index" do
    get autographs_url
    assert_response :success
  end

  test "should get new" do
    get new_autograph_url
    assert_response :success
  end

  test "should create autograph" do
    assert_difference('Autograph.count') do
      post autographs_url, params: { autograph: { authentication: @autograph.authentication, authentication_number: @autograph.authentication_number, name: @autograph.name } }
    end

    assert_redirected_to autograph_url(Autograph.last)
  end

  test "should show autograph" do
    get autograph_url(@autograph)
    assert_response :success
  end

  test "should get edit" do
    get edit_autograph_url(@autograph)
    assert_response :success
  end

  test "should update autograph" do
    patch autograph_url(@autograph), params: { autograph: { authentication: @autograph.authentication, authentication_number: @autograph.authentication_number, name: @autograph.name } }
    assert_redirected_to autograph_url(@autograph)
  end

  test "should destroy autograph" do
    assert_difference('Autograph.count', -1) do
      delete autograph_url(@autograph)
    end

    assert_redirected_to autographs_url
  end
end
