require 'test_helper'

class LifecyclesControllerTest < ActionController::TestCase
  setup do
    @lifecycle = lifecycles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:lifecycles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create lifecycle" do
    assert_difference('Lifecycle.count') do
      post :create, lifecycle: {  }
    end

    assert_redirected_to lifecycle_path(assigns(:lifecycle))
  end

  test "should show lifecycle" do
    get :show, id: @lifecycle
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @lifecycle
    assert_response :success
  end

  test "should update lifecycle" do
    patch :update, id: @lifecycle, lifecycle: {  }
    assert_redirected_to lifecycle_path(assigns(:lifecycle))
  end

  test "should destroy lifecycle" do
    assert_difference('Lifecycle.count', -1) do
      delete :destroy, id: @lifecycle
    end

    assert_redirected_to lifecycles_path
  end
end
