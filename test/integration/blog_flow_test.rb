require "test_helper"

class BlogFlowTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "can see the welcome page" do
    get "/"
    assert_select "h1", "Welcome#index"
  end
  test "can create an article" do
    get "/articles/new"
    assert_response :success
  
    article = Article.create(title: "can create", body: "article successfully.")
    assert article.persisted?

    post "/articles", params: { article: { title: "can create", body: "article successfully." } }
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select "p", "Article was successfully created."
  end
end
