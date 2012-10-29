require 'test_helper'

class KeywordUrlsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:keyword_urls)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create keyword_url" do
    assert_difference('KeywordUrl.count') do
      post :create, :keyword_url => { }
    end

    assert_redirected_to keyword_url_path(assigns(:keyword_url))
  end

  test "should show keyword_url" do
    get :show, :id => keyword_urls(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => keyword_urls(:one).to_param
    assert_response :success
  end

  test "should update keyword_url" do
    put :update, :id => keyword_urls(:one).to_param, :keyword_url => { }
    assert_redirected_to keyword_url_path(assigns(:keyword_url))
  end

  test "should destroy keyword_url" do
    assert_difference('KeywordUrl.count', -1) do
      delete :destroy, :id => keyword_urls(:one).to_param
    end

    assert_redirected_to keyword_urls_path
  end
end
