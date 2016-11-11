Pic.populate(10) do |p|
  #Rails.logger.warn { "~~~~~~~~~~~~~\nLOGGER\n~~~~~~~~~~~~~~\n #{p.inspect}" }
  
  
  user_id = User.find(p.id)
  
  p.user_id     = user_id
  p.title       = Faker::Book.title
  p.description = Faker::Hipster.paragraph
end