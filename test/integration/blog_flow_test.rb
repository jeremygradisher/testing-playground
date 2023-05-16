require "test_helper"

class BlogFlowTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "can see the welcome page" do
    get "/"
    assert_select "h1", "Welcome#index"
  end
end
