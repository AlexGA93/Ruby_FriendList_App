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

At this point we have a full friend's routes structure. We can access to the sections that have the CRUD functions (we can see them in the table above). 

## 6. Styling App with Bootstrap
---
In this section you must look every friend's component that renders html content. It has been updated with table, buttons and labels modified by Bootstrap.

Also we've added a 'notice' function .

## 7. User Management
---
We're going to implement a Login system that we'll be capable to:

- Register a perosnal account.
- Log in.
- Edit our profile.
- Change our account's password.

For that, we're going to use a gem called '**devise**'. It can be downloaded from the official site: **https://rubygems.org/gems/devise**.
In this case we are gonig to copy the gemfile to paste it into our project's Gemfile.

```
gem 'devise', '~> 4.8'
```

And make a couple of steps in our terminal:

- 1.Install all our gems( old ones and new ones)
```
bundle install
```
- 2.Go to devise Github's page at gem's 'Homepage' section: **https://github.com/heartcombo/devise**. And we've to search the 'Getting started section'. There it will show us the list of commands and actions that we need to follow to install this gems with all its dependencies.
```
rails generate devise:install
```
We're going to follow the terminal's instructions that this command gives us with the installation.

    ```
    Running via Spring preloader in process 350839
      create  config/initializers/devise.rb
      create  config/locales/devise.en.yml
        ===============================================================================

        Depending on your application's configuration some manual setup may be required:

          1. Ensure you have defined default url options in your environments files. Here
            is an example of default_url_options appropriate for a development environment
            in config/environments/development.rb:

              config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }

            In production, :host should be set to the actual host of your application.

            * Required for all applications. *

          2. Ensure you have defined root_url to *something* in your config/routes.rb.
            For example:

              root to: "home#index"
            
            * Not required for API-only Applications *

          3. Ensure you have flash messages in app/views/layouts/application.html.erb.
            For example:

              <p class="notice"><%= notice %></p>
              <p class="alert"><%= alert %></p>

            * Not required for API-only Applications *

          4. You can copy Devise views (for customization) to your app by running:

              rails g devise:views
              
            * Not required *

        ===============================================================================

    ```

  **WARNINGS**: 
  - Don't forget to repeat the step 1 to **friends/config/environments/production.rb** and for **friends/config/environments/development.rb** too.
  - Step two and three are already done.
  - Step four will shows us all the files created similar to friend's files.
  ```
  Running via Spring preloader in process 355540
  invoke  Devise::Generators::SharedViewsGenerator
  create    app/views/devise/shared
  create    app/views/devise/shared/_error_messages.html.erb
  create    app/views/devise/shared/_links.html.erb
  invoke  form_for
  create    app/views/devise/confirmations
  create    app/views/devise/confirmations/new.html.erb
  create    app/views/devise/passwords
  create    app/views/devise/passwords/edit.html.erb
  create    app/views/devise/passwords/new.html.erb
  create    app/views/devise/registrations
  create    app/views/devise/registrations/edit.html.erb
  create    app/views/devise/registrations/new.html.erb
  create    app/views/devise/sessions
  create    app/views/devise/sessions/new.html.erb
  create    app/views/devise/unlocks
  create    app/views/devise/unlocks/new.html.erb
  invoke  erb
  create    app/views/devise/mailer
  create    app/views/devise/mailer/confirmation_instructions.html.erb
  create    app/views/devise/mailer/email_changed.html.erb
  create    app/views/devise/mailer/password_change.html.erb
  create    app/views/devise/mailer/reset_password_instructions.html.erb
  create    app/views/devise/mailer/unlock_instructions.html.erb

  ```
We come back to Github's page to crate a model changing 'MODEL' to 'user'.
```
rails generate devise user
```
And it will print the proccess info:
```
Running via Spring preloader in process 358311
      invoke  active_record
      create    db/migrate/20210811135710_devise_create_users.rb
      create    app/models/user.rb
      invoke    test_unit
      create      test/models/user_test.rb
      create      test/fixtures/users.yml
      insert    app/models/user.rb
       route  devise_for :users

```
Then having created a database migration, we need to push that database migration like always:
```
rails db:migrate
```
With the next print: 
```
== 20210811135710 DeviseCreateUsers: migrating ================================
-- create_table(:users)
   -> 0.0017s
-- add_index(:users, :email, {:unique=>true})
   -> 0.0007s
-- add_index(:users, :reset_password_token, {:unique=>true})
   -> 0.0007s
== 20210811135710 DeviseCreateUsers: migrated (0.0033s) =======================

```

Our next step is to add a few more links to our navbar, so let's go to that component and add the following links:

```
  <% if user_signed_in? %>
    <li class="nav-item">
      <%= link_to 'Add Friend', new_friend_path, class:"nav-link" %>
    </li>
    <li class="nav-item">
      <%= link_to 'Log Out', destroy_user_session_path, data:{method: :delete} ,class:"nav-link" %>
    </li>

    <li class="nav-item">
        <%= link_to 'Edit Profile', edit_user_registration_path, class:"nav-link" %>
    </li>
  <% else %>
    <li class="nav-item">
        <%= link_to 'Register', new_user_registration_path, class:"nav-link" %>
    </li>

    <li class="nav-item">
        <%= link_to 'Log In', new_user_session_path, class:"nav-link" %>
    </li>
  <% end %>

```

See that our navbar has been modified to show only add frinds and log out if we are logged.

```
rails routes
```

## 8. Style Devise Views
---

First of all, we're going to apply Bootstrap to the Log in Form (**app/views/devise/sessions/new.html.erb**):

```
<h2>Log in</h2>

<%= form_for(resource, as: resource_name, url: session_path(resource_name)) do |f| %>
  <div class="field form-group">
    <%= f.label :email %><br />
    <%= f.email_field :email,class:"form-control",placeholder:"Email" ,autofocus: true, autocomplete: "email" %>
  </div>
  <br />
  <div class="field form-group">
    <%= f.label :password %><br />
    <%= f.password_field :password,class:"form-control" ,placeholder:"Password" , autocomplete: "current-password" %>
  </div>
  <br />
  <% if devise_mapping.rememberable? %>
    <div class="field form-group">
      <%= f.check_box :remember_me, class:"form-check-input" %>
      <%= f.label :remember_me %>
    </div>
  <% end %>
  <br />
  <div class="actions">
    <%= f.submit "Log in",class:'btn btn-secondary' %>
  </div>
<% end %>
<br />
<%= render "devise/shared/links" %>
```

NOTE: If we look into **app/views/devise/shared/_links.html.erb** we can see the links to access from login form line 'Sign up & Forgot your password?'.

We're going to apply Bootstrap styles to all form pages:
  
  - 1. Log in (**app/views/devise/sessions/new.html.erb**)
    ```
      <div class="card">
    <div class="card-header">
      <h2>Log in</h2>
    </div>
    <div class="card-body">
      <%= form_for(resource, as: resource_name, url: session_path(resource_name)) do |f| %>
        <div class="field form-group">
          <%= f.label :email %><br />
          <%= f.email_field :email,class:"form-control",placeholder:"Email" ,autofocus: true, autocomplete: "email" %>
        </div>
        <br />
        <div class="field form-group">
          <%= f.label :password %><br />
          <%= f.password_field :password,class:"form-control" ,placeholder:"Password" , autocomplete: "current-password" %>
        </div>
        <br />
        <% if devise_mapping.rememberable? %>
          <div class="field form-group">
            <%= f.check_box :remember_me, class:"form-check-input" %>
            <%= f.label :remember_me %>
          </div>
        <% end %>
        <br />
        <div class="actions">
          <%= f.submit "Log in",class:'btn btn-secondary' %>
        </div>
      <% end %>
    </div>
  </div>
  <br />
  <%= render "devise/shared/links" %>

    ```
  - 2. Add Friend (**app/views/friends/new.html.erb**)
    ```
    <div class="card">
      <div class="card-header">
        <h1>New Friend</h1>
      </div>
      <div class="card-body">
        <%= render 'form', friend: @friend %>
        <%= link_to 'Back', friends_path, class:"btn btn-secondary" %>
      </div>
    </div>
    ```
  - 3. Edit Profile (**app/views/devise/registrations/edit.html.erb**)
    ```
        <div class="card">
      <div class="card-header">
        <h2>Edit Profile <%= resource_name.to_s.humanize %></h2>
      </div>
      <div class="card-body">
        <%= form_for(resource, as: resource_name, url: registration_path(resource_name), html: { method: :put }) do |f| %>
          <%= render "devise/shared/error_messages", resource: resource %>

          <div class="field form-group">
            <% f.label :email %><br />
            <%= f.email_field :email, autofocus: true, autocomplete: "email", class:"form-control", placeholder:"Email" %>
          </div>

          <% if devise_mapping.confirmable? && resource.pending_reconfirmation? %>
            <div>Currently waiting confirmation for: <%= resource.unconfirmed_email %></div>
          <% end %>
          <br/>
          <div class="field form-group">
            <% f.label :password %> <!--<i>(leave blank if you don't want to change it)</i>--><br />
            <%= f.password_field :password, autocomplete: "new-password", class:"form-control", placeholder:"Password (leave blank if you don't want to change it)" %>
            <% if @minimum_password_length %>
            
              <em><%= @minimum_password_length %> characters minimum</em>
              
            <% end %>
          </div>
          <br/>
          <div class="field form-group">
            <% f.label :password_confirmation %><br />
            <%= f.password_field :password_confirmation, autocomplete: "new-password", class:"form-control", placeholder:"Password Confirmation" %>
          </div>
          <br/>
          <div class="field form-group">
            <% f.label :current_password %> <!--<i>(we need your current password to confirm your changes)</i>--><br />
            <%= f.password_field :current_password, autocomplete: "current-password", class:"form-control", placeholder:"Current Password(we need your current password to confirm your changes)" %>
          </div>
          <br/>
          <div class="actions">
            <%= f.submit "Update" , class:'btn btn-info'%>
            <br/>
            <%= link_to "Back", :back %>
            </div>
        <% end %>
        </div>
    </div>
    <br/>


    <div class="card">
      <div class="card-header">
        <h3>Cancel my account</h3>
      </div>
      <div class="card-body">
      <p>Unhappy? <%= button_to "Cancel my account", registration_path(resource_name), data: { confirm: "Are you sure?" }, method: :delete, class:'btn btn-danger' %></p>
      </div>
    </div>

    <br/><br/>
    ```
  - 4. Register (**app/views/devise/registrations/new.html.erb**)
    ```

      <div class="card">
        <div class="card-header">
          <h2>Sign up</h2>
        </div>
        <div class="card-body">
          <%= form_for(resource, as: resource_name, url: registration_path(resource_name)) do |f| %>
            <%= render "devise/shared/error_messages", resource: resource %>
          
            <div class="field form-group">
              <% f.label :email %><br />
              <%= f.email_field :email, autofocus: true, autocomplete: "email" ,placeholder:"Email"%>
            </div>
            <br/>
            <div class="field form-group">
              <% f.label :password %>
              <% if @minimum_password_length %>
              <em>(<%= @minimum_password_length %> characters minimum)</em>
              <% end %><br />
              <%= f.password_field :password, autocomplete: "new-password",placeholder:"Password" %>
            </div>
          
            <div class="field form-group">
              <% f.label :password_confirmation %><br />
              <%= f.password_field :password_confirmation, autocomplete: "new-password", placeholder:"Repeat Password" %>
            </div>
            <br/>
            <div class="actions">
              <%= f.submit "Sign up" ,class:'btn btn-secondary' %>
            </div>
          <% end %>
        </div>
      </div>


      <%= render "devise/shared/links" %>

    ```
