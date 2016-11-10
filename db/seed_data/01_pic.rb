Pic.populate(10) do |p|
  p.title       = Faker::Book.title
  p.description = Faker::Hipster.paragraph
end
