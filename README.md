# Instagram Clone

This is a prototype aimed at teaching developers a few fundamentals of Instagram.  This is not production-ready and will not be able to scale 100M users. If you're looking for a scalable solution, I suggest looking into [Phoenix Framework](http://www.phoenixframework.org/) or an  [Erlang Framework](https://github.com/ChicagoBoss/ChicagoBoss/wiki/Comparison-of-Erlang-Web-Frameworks).

# Getting Started

## Step 0

```language-powerbash
bundle install --full-index
```


## Step 1

Create a new Rails 5.0 application with a Postgres DB.
```language-powerbash
rails _5.0.0_ new clone-instagram-rails -d postgresql
```



## Step 2

Paste this into your Gemfile

```language-ruby

# ###
# Authentication
# ###
gem 'devise', '~> 4.2'

# ###
# Configuration
# ###

# Environmental variables
gem 'dotenv-rails', :groups => [:development, :test]
# Server Watcher
gem 'rerun', :groups => [:development, :test]
#

# ###
# Testing
# ###

# Populate fake test data
gem 'populator', :groups => [:development, :test]
# Populate fake test data
gem 'faker', :groups => [:development, :test]

# ###
#Views
# ###

# Simplified forms
gem 'simple_form', '~> 3.2', '>= 3.2.1'
# HAML template engine
gem 'haml-rails', '~> 0.9.0'
# Bootstrap templates
gem 'bootstrap', '~> 4.0.0.alpha3.1'
# Easily include static pages https://github.com/thoughtbot/high_voltage
gem 'high_voltage'
# Convert existing .erb to .haml such as /views/layouts/application.html.erb
gem 'erb2haml', :groups => [:development]
```


### Step 3

Add this to ```config/application.rb```. This will tell rails to autogenerate .haml files instead of the default .erb files. 
```language-ruby
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    #CHANGED
    config.generators do |g|
      g.template_engine :haml
    end
  end
```


### Step 4 - Convert existing .erb to .haml

Convert the existing .erb files to .haml by **picking one of these commands**.

Keep .erb files
```language-powerbash
rails haml:convert_erbs
```

Replace .erb files
```language-powerbash
rails haml:replace_erbs
```


### Step 5 - Simple Form

Run this command to complete the ```simple_form``` gem install. This will connect ```simple_form``` with Bootstrap templates.
```language-powerbasah
rails g simple_form:install --bootstrap
```



### Step 6 - Create a Model, Controller and Views through Scaffold

Some people are really against Scaffolding but I don't agree. There's nothing wrong with instant convenience.  It's no different than [modern day baking](https://youtu.be/fEsPOt8MG7E?t=1309). LOL.
```language-powerbash
rails g scaffold pic title:string description:text
```

Regarding security, don't worry, we'll add that next.


Update the database schema by running a ```rails migration```.
```language-powerbash
rails db:migrate
```

Add this to ```config/routes.rb``` or at least make sure this is there.
```language-html
Rails.application.routes.draw do
  resources :pics

  #CHANGED
  root "pics#index"
end
```


### Step 6 - Install Devise

Install the Devise gem and **follow the remaining command line instructions**.
```language-powerbash
rails g devise:install
```

Install the views and now you will reap the .html benefits
```language-powerbash
rails g devise:views
```

Create a User model through Devise gem.
```language-powerbash
rails g devise User
```

Associate devise's User to a specific Pic.
```language-powerbash
rails g migration add_user_id_to_pics user_id:index
```



### Step 7 - Style your app

Add this bootstrap stuff to ```app/assets/stylesheets/application.scss```
```language-css
@import "bootstrap-sprockets";
@import "bootstrap";
```

The easiest way to style your app is to vist the [Twitter Bootstrap](http://v4-alpha.getbootstrap.com/examples/) page and find an exmple you want to copy.

Once you find a template you like, go to ```Inspect```, copy the HTML and paste it into the [HTML to HAML](http://htmltohaml.com/) converter.



### Step 8 - Add Images

The most popular rails gem for adding images is ```paperclip```.

You'll need this to render images.
```language-powerbash
brew install imagemagick
```

Ghostscript is important if you want to upload PDF files.
```language-powerbash
brew install gs
```

Then add ```gem paperclip``` and follow these [Quickstart instructions](https://github.com/thoughtbot/paperclip#quick-start).

```language-powerbash
rails g paperclip pic image
```

---


## Step 9 - Add Liking

Follow [these gem instructions](http://www.mattmorgante.com/technology/votable).

Add this ```models/pic.rb```.

```language-ruby
class Pic < ActiveRecord::Base
  ...
  acts_as_votable
end
```


Add this to ```config/routes.rb```
```language-ruby
Rails.application.routes.draw do
  ...
  resources :pics do |p|
    member do
      put "like", to: "pic#upvote"
    end    
  end
end
```


Add this to ```controllers/pics_controller.rb```.
```language-ruby
class PicsController < ApplicationController
  # Add upvote as a before action that requires :set_pic
  before_action :set_pic, only: [..., :upvote, :downvote]
  
  # Restrict user behavior by only allowing for :index and :show to appear
  before_action :authenticate_user!, except: [:index, :show]
```


Add this to ```controllers/pics_controller.rb```.

```language-ruby
  # ################
  # acts_as_votable
  # ################
  #Once you update, redirect back to the show page
  def upvote
    @pic.upvote_by current_user
    redirect_to :back
  end

  def downvote
    @pic.downvote_by current_user
    redirect_to :back
  end
```

---


# Resources

- [Seed Data Examples](https://github.com/chrisjmendez/rails-5-cheatsheet/blob/master/db/seed_data/01_user.rb)
- [Convert HTML to HAML](http://htmltohaml.com/)

