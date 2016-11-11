User.populate(10) do |u|
  u.email = Faker::Internet.email
  u.encrypted_password = BCrypt::Password.create( Faker::Internet.password(8, 20, true) )  
  u.sign_in_count = 0
end
