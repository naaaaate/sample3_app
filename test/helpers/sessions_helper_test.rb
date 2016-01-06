require 'test_helper'

class SessionsHelperTest < ActionView::TestCase
  def setup
    @user = users(:michael)
    remember(@user)
  end

  test 'current_user method returns the right user, when the sesssion is nil' do
    assert_equal @user, current_user
    assert is_logged_in?
  end

  test 'checks the authenticated? method.. current_user method returns nil when the remember_digest is wrong' do
    @user.update_attribute(:remember_digest, User.digest(User.new_token))
    assert_nil current_user
  end

end
