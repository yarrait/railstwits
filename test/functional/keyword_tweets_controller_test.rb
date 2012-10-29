require 'test_helper'

class KeywordTweetsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:keyword_tweets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create keyword_tweet" do
    assert_difference('KeywordTweet.count') do
      post :create, :keyword_tweet => { }
    end

    assert_redirected_to keyword_tweet_path(assigns(:keyword_tweet))
  end

  test "should show keyword_tweet" do
    get :show, :id => keyword_tweets(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => keyword_tweets(:one).to_param
    assert_response :success
  end

  test "should update keyword_tweet" do
    put :update, :id => keyword_tweets(:one).to_param, :keyword_tweet => { }
    assert_redirected_to keyword_tweet_path(assigns(:keyword_tweet))
  end

  test "should destroy keyword_tweet" do
    assert_difference('KeywordTweet.count', -1) do
      delete :destroy, :id => keyword_tweets(:one).to_param
    end

    assert_redirected_to keyword_tweets_path
  end
end
