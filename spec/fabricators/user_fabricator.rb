Fabricator(:user) do
  f_name = Faker::Name.first_name
  l_name = Faker::Name.last_name
  first_name { f_name }
  last_name { l_name }
  email { Faker::Internet.email }
  city { Faker::Address.city }
  post_code { Faker::Address.postcode }
  password { "Password" }
  avatar { Faker::Avatar.image("#{f_name}-#{l_name}", "200x200" ) }
  thumb { Faker::Avatar.image("#{f_name}-#{l_name}", "55x55" ) }
end