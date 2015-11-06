require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  test "layout links" do
    get root_path
    assert_template 'pages/welcome'
    assert_select "a[href=?]", root_path
    assert_select "a[href=?]", statistics_path
    assert_select "a[href=?]", login_path
    get signup_path
    assert_template 'players/signup'
  end
end
