require 'test_helper'

class PurchaseTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @purchase_type = purchase_types(:one)
  end

  test "should get index" do
    get purchase_types_url
    assert_response :success
  end

  test "should get new" do
    get new_purchase_type_url
    assert_response :success
  end

  test "should create purchase_type" do
    assert_difference('PurchaseType.count') do
      post purchase_types_url, params: { purchase_type: { type: @purchase_type.type } }
    end

    assert_redirected_to purchase_type_url(PurchaseType.last)
  end

  test "should show purchase_type" do
    get purchase_type_url(@purchase_type)
    assert_response :success
  end

  test "should get edit" do
    get edit_purchase_type_url(@purchase_type)
    assert_response :success
  end

  test "should update purchase_type" do
    patch purchase_type_url(@purchase_type), params: { purchase_type: { type: @purchase_type.type } }
    assert_redirected_to purchase_type_url(@purchase_type)
  end

  test "should destroy purchase_type" do
    assert_difference('PurchaseType.count', -1) do
      delete purchase_type_url(@purchase_type)
    end

    assert_redirected_to purchase_types_url
  end
end
