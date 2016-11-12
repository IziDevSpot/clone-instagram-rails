namespace :app do

  desc %Q{ ›› Build App From Scratch }
  task init: :environment do
    #We're skipping turbo links becuase we want to use our own View solution (aka React)
    sh %{ rails _5.0.0_ new clone-instagram-rails --force -d postgresql --skip-turbolinks }
    sh %{ rake db:create }
    # Add Paperclip
    sh %{ rails g paperclip pic image }
    # Add an aditional column to the table in order to offer likes
    sh %{ rails g acts_as_votable:migration }
    sh %{  }
    sh %{  }
    sh %{  }
  end
end



# Add this to config/application.rb
def insert_into_application
  config.generators do |g|
      g.stylesheets = false
      g.javascripts = false
      g.test_framework  :rspec, fixture: false
      g.template_engine :haml
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
  end 
end