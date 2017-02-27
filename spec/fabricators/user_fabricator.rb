Fabricator(:user) do
  first_name { Faker::Name.first_name }
  last_name { Faker::Name.last_name }
  email { Faker::Internet.email }
  city { Faker::Address.city }
  post_code { Faker::Address.postcode }
  password { "Password" }
  avatar { Faker::Avatar.image }
end