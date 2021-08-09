# Ruby on Rails Friend list app

Brief friend list app built on Ruby on rails to knowledge.

## 1. Create project's folder.

```
rails new friends
```
Ifyou have an error with the following message: "TypeError: superclass mismatch for class Command", you can fixed it adding these commands:
 ```
 sudo dpkg -r --force-depends  ruby-thor
 sudo gem install thor
 ```

## 2. Creating our first controller.
Using Ruby's generator we 're going to create a controller named 'home':

```
rails g controller home index
```

It will create the following files at the routes indicated:
```
Running via Spring preloader in process 98217
      create  app/controllers/home_controller.rb
       route  get 'home/index'
      invoke  erb
      create    app/views/home
      create    app/views/home/index.html.erb
      invoke  test_unit
      create    test/controllers/home_controller_test.rb
      invoke  helper
      create    app/helpers/home_helper.rb
      invoke    test_unit
      invoke  assets
      invoke    scss
      create      app/assets/stylesheets/home.scss
 
```

It will allow us to access in ur website to **localhost:3000/home/index** using a route (/friend/config/routes.rb) to acces to the constroller (/friend/app/controllers/home_controller.rb) and render a html.erb script (/friend/app/views/home/index.html.erb).

In our html file we can see only body's content, but the rest of the html script code is located at **/friend/app/views/layouts/application.html.erb**

```
<!DOCTYPE html>
<html>
  <head>
    <title>Friend</title>
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <%= csrf_meta_tags %>
    <%= csp_meta_tag %>

    <%= stylesheet_link_tag 'application', media: 'all', 'data-turbolinks-track': 'reload' %>
    <%= javascript_pack_tag 'application', 'data-turbolinks-track': 'reload' %>
  </head>

  <body>
    <%= yield %>
  </body>
</html>
```

NOTE: when we put the following tag to ruby '<%= some_content %>', **' = '** means that we're going to put this content out of screen.

## 3. Dealing with Routes.

- Command to see ruby's routes table
```
rails routes
```
We're gouing to add a new page named 'about'. For this we'll create the new html.erb script at **/friend/app/views/home/about.html.erb**. 

```
<h1>About us...</h1>
```

In second place, we need a controller toconnect with html script at **/friend/app/controllers/home_controller.rb**.

```
class HomeController < ApplicationController
  def index
  end

  def about #<------
  end
end

```

Finally we only need to add a route to access. We can find it at **/friend/config/routes.rb**.

```
Rails.application.routes.draw do
  get 'home/about' #<--->

  root "home#index"
end

```
## 4. Using [Bootsrap](https://getbootstrap.com/docs/5.0/getting-started/introduction/)

We're going to edit our **/friend/app/views/layouts/application.html.erb** adding some code from bootstrap. We can see a copule of contents to add to our application:

We're rendering a navbar code located at **/friend/app/views/home/_header.html.erb**
 - [Navbar code source](https://getbootstrap.com/docs/5.0/components/navbar/) which code is loaded from "/friend/app/views/home/_header.html.erb"

 - Edit to add two links

```
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
  <div class="container-fluid">

    <!-- <a class="navbar-brand" href="#">FriendList App</a> -->
    <%= link_to 'FriendList App', root_path, class:"navbar-brand" %>

    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item">
            <!-- <a class="nav-link" href="#">Link</a> -->
            <%= link_to 'About Us', home_about_path, class:"nav-link" %>
        </li>
        
      </ul>
      <form class="d-flex">
        <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
        <button class="btn btn-outline-success" type="submit">Search</button>
      </form>
    </div>
  </div>
</nav>
```

We've to see that links are been changed to Ruby's sintaxis, like:
```
    <!-- <a class="navbar-brand" href="#">FriendList App</a> -->
    <%= link_to 'FriendList App', root_path, class:"navbar-brand" %>    
```
and... 
```
    <li class="nav-item">
        <!-- <a class="nav-link" href="#">Link</a> -->
        <%= link_to 'About Us', home_about_path, class:"nav-link" %>
    </li>
```
We can see that Ruby links the Link named 'About Us' with a variable called 'home_about_path' referring to **/app/views/home/about.html.erb** script.


## 5. CRUD Scaffold
---
### Generating a scaffold

Scaffold is a Ruby component that it allows to create all the CRUD system.

So we're going to create a scaffold and a database model(table) called 'friends'.

Insecond place we needto think what we need in our table named 'friend' like first name, second name, age, etc.

```
sudo rails g scaffold friends first_name:string last_name:string email:string phone:string twitter:string --skip-collision-check

```
- **Note**: Styles may be affected because scaffold creates a couple of .scss scripts, so we're going to delete it(**/friends/app/assets/stylesheets/scaffolds.scss**).

We can see that it created a database migration with the table instructions at **/friends/db/migrate/20210804141735_create_friends.rb**.
```
class CreateFriends < ActiveRecord::Migration[6.1]
  def change
    create_table :friends do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.string :twitter

      t.timestamps
    end
  end
end
```

Next, we'll push the migration into the database
```
rails db:migrate
```
this would create a Schema to our database at **/friends/db/schema.rb**.
```
ActiveRecord::Schema.define(version: 2021_08_04_141735) do

  create_table "friends", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "phone"
    t.string "twitter"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
```
With de previous scaffold's generation command, Ruby has reated several html components like :
```
invoke  active_record
      create    db/migrate/20210804141735_create_friends.rb
      create    app/models/friend.rb
      invoke    test_unit
      create      test/models/friend_test.rb
      create      test/fixtures/friends.yml
      invoke  resource_route
       route    resources :friends
      invoke  scaffold_controller
      create    app/controllers/friends_controller.rb
      invoke    erb
      create      app/views/friends
      create      app/views/friends/index.html.erb
      create      app/views/friends/edit.html.erb
      create      app/views/friends/show.html.erb
      create      app/views/friends/new.html.erb
      create      app/views/friends/_form.html.erb
      invoke    resource_route
      invoke    test_unit
      create      test/controllers/friends_controller_test.rb
      create      test/system/friends_test.rb
      invoke    helper
      create      app/helpers/friends_helper.rb
      invoke      test_unit
      invoke    jbuilder
      create      app/views/friends/index.json.jbuilder
      create      app/views/friends/show.json.jbuilder
      create      app/views/friends/_friend.json.jbuilder
      invoke  assets
      invoke    scss
      create      app/assets/stylesheets/friends.scss
      invoke  scss
      create    app/assets/stylesheets/scaffolds.scss
```