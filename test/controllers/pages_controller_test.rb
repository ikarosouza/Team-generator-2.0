require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "home is accessible without login" do
    get root_url

    assert_response :success
    assert_includes response.body, "Entrar"
  end
end
