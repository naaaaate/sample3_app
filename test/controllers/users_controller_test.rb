require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  def setup
    @user= users(:michael)
    @other_user = users(:archer)

  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should redirect edit action when user is not logged in" do
    #get the edit action of a user to simulate edit profile
    get :edit, id: @user
    #assert tht a error message pops up bc must be signed in
    assert_not flash.empty?
    #assert a redirect to the login path url bc user has no access
    assert_redirected_to login_url
  end

  test "should redirect update action when user is not logged in" do
    patch :update, id: @user, user: {name: @user.name, email:@user.email }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect edit action when logged in as wrong user tring to edit another user's settings" do
    log_in_as(@other_user)
    get :edit, id: @user
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect update action when logged in as wrong user trying to update another user's settings" do
    log_in_as(@other_user)
    patch :update, id: @user, user: {name: @user.name, email: @user.email}
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect index action when user is not logged in" do
    get :index
    assert_redirected_to login_url
  end

  test "should redirect destroy to login url when user is not logged in" do
    assert_no_difference 'User.count' do
      delete :destroy, id: @user
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when logged in as a non admin" do
    log_in_as(@other_user)
    assert_no_difference 'User.count' do
      delete :destroy, id: @user
    end
    assert_redirected_to root_url
  end


end
