require 'test_helper'

class TodaysSpecialsControllerTest < ActionController::TestCase
  setup do
    @todays_special = todays_specials(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:todays_specials)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create todays_special" do
    assert_difference('TodaysSpecial.count') do
      post :create, todays_special: { description: @todays_special.description, title: @todays_special.title, type: @todays_special.type, url: @todays_special.url }
    end

    assert_redirected_to todays_special_path(assigns(:todays_special))
  end

  test "should show todays_special" do
    get :show, id: @todays_special
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @todays_special
    assert_response :success
  end

  test "should update todays_special" do
    put :update, id: @todays_special, todays_special: { description: @todays_special.description, title: @todays_special.title, type: @todays_special.type, url: @todays_special.url }
    assert_redirected_to todays_special_path(assigns(:todays_special))
  end

  test "should destroy todays_special" do
    assert_difference('TodaysSpecial.count', -1) do
      delete :destroy, id: @todays_special
    end

    assert_redirected_to todays_specials_path
  end
end
