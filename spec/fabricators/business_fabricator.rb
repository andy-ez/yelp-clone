Fabricator(:business) do
  name { Faker::Company.name }
  expense { [1, 2, 3, 4].sample } 
  address_first_line { Faker::Address.street_address }
  city { Faker::Address.city }
  post_code { Faker::Address.postcode }
  phone_number { Faker::PhoneNumber.phone_number }
  description { Faker::Lorem.paragraph(2) }
end