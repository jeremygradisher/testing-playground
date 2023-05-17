# Testing Playground:

Reference: https://guides.rubyonrails.org/testing.html

1. Create the testing-playground:
rails new testing-playground --css=bootstrap --javascript=esbuild --database=postgresql

2. We can now run bundle install to install the correct version of the gem.
```
bundle install
```

3. Now that our application is ready, let's type the bin/setup command to install the dependencies and create the database:
```
bin/setup
```

4. We can now run the rails server, and the scripts that precompile the CSS and the JavaScript code with the bin/dev command:
```
bin/dev
```

5. We can now go to http://localhost:3000, and we should see the Rails boot screen.

6. Check to see which version of Bootstrap I am working with:
```
cat package.json | grep bootstrap
```
I am running: "bootstrap": "^5.2.3",

7. Saved it to Github:
```
git init
git add -A
git commit -m "Initial commit"
git branch -M main
git remote add origin https://github.com/jeremygradisher/testing-playground.git
git push -u origin main
```

8. Genereate a model to test with:
```
bin/rails generate model Article title:string body:text
```

9. Run the migration:
```
bin/rails db:migrate
```

10. Open the rails console:
```
bin/rails console
```

11. Initialize a new Article:
```
article = Article.new(title: "Hello Rails", body: "I am on Rails!")
```

12. Save the Article:
```
article.save
```

13. Create an articles controller and a few more resources we need...

14. First failing test:
```
test "should not save article without title" do
  article = Article.new
  assert_not article.save
end
```
```
F

Failure:
ArticleTest#test_should_not_save_article_without_title [/Users/jg-work-computer/testing-playground/test/models/article_test.rb:6]:
Expected true to be nil or false


rails test test/models/article_test.rb:4



Finished in 0.027369s, 36.5377 runs/s, 36.5377 assertions/s.
1 runs, 1 assertions, 1 failures, 0 errors, 0 skips
```

To test this, we can run the following command:
```
bin/rails test test/models/article_test.rb:4
```
```
F

Failure:
ArticleTest#test_should_not_save_article_without_title [/Users/jg-work-computer/testing-playground/test/models/article_test.rb:6]:
Saved the article without a title


rails test test/models/article_test.rb:4



Finished in 0.021199s, 47.1720 runs/s, 47.1720 assertions/s.
1 runs, 1 assertions, 1 failures, 0 errors, 0 skips
```


15. We can wite it a little better, Running this test shows the friendlier assertion message:
```
test "should not save article without title" do
  article = Article.new
  assert_not article.save, "Saved the article without a title"
end
```

16. add to article.rb and re-run the test:
```
class Article < ApplicationRecord
    validates :title, presence: true
end
```

17. Either of these will run it currently:
```
bin/rails test test/models/article_test.rb
or
bin/rails test test/models/article_test.rb:4
```

18. added to article_test.rb:
```
test "should report error" do
  # some_undefined_variable is not defined elsewhere in the test case
  some_undefined_variable
  assert true
end
```

19. Then run the test:
```
bin/rails test test/models/article_test.rb
```

20. fixed the error:
```
test "should report error" do
  # some_undefined_variable is not defined elsewhere in the test case
  assert_raises(NameError) do
    some_undefined_variable
  end
end
```

21. Run all tests:
```
bin/rails test
or run all system tests:
bin/rails test:system
```

22. You can also run a particular test method from the test case by providing the -n or --name flag and the test's method name.
```
bin/rails test test/models/article_test.rb -n test_the_truth
```

23. Run all tests in a single file:
``` 
bin/rails test test/models/article_test.rb
```

You can also run a test at a specific line by providing the line number.
```
$ bin/rails test test/models/article_test.rb:6 # run specific test and line
```

You can also run an entire directory of tests by providing the path to the directory.

```
bin/rails test test/controllers # run all tests from specific directory
```


24. The test runner also provides a lot of other features like failing fast, deferring test output at the end of the test run and so on. Check the documentation of the test runner as follows:

```
bin/rails test -h
```

Usage: rails test [options] [files or directories]

## Model Testing:
```
bin/rails test test/models/article_test.rb
or
bin/rails test test/models
```

## System Testing
```
bin/rails test:system
```

## Integration testing
```
bin/rails test test/integration
```

26. added a Welcome page and a test for it:
```
bin/rails test test/integration
```

27. Left off here:https://guides.rubyonrails.org/testing.html#creating-articles-integration

28. test creating a new article (test/integration/blog_flow_test.rb):
```ruby
test "can create an article" do
  get "/articles/new"
  assert_response :success

  post "/articles",
    params: { article: { title: "can create", body: "article successfully." } }
  assert_response :redirect
  follow_redirect!
  assert_response :success
  assert_select "p", "Title:\n  can create"
end
```

29. Run the test:
``` 
bin/rails test test/integration/blog_flow_test.rb
or just run "can create an article":
bin/rails test test/integration/blog_flow_test.rb -n "can create an article"
or by the test definition line number:
bin/rails test test/integration/blog_flow_test.rb:11
```
### Integration tests are a great place to experiment with all kinds of use cases for our applications.

---

## Functional Tests for Your Controllers
When writing functional tests, you are testing how your actions handle the requests and the expected result or response, in some cases an HTML view.

The easiest way to see functional tests in action is to generate a controller using the scaffold generator:
```
bin/rails generate scaffold_controller article title:string body:text
```

This will generate the controller code and tests for an Article resource. You can take a look at the file articles_controller_test.rb in the test/controllers directory.

## Generate test scaffold:
```
bin/rails generate test_unit:scaffold article
```




