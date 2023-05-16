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

13. 