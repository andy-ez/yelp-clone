Fabricator(:review) do
  business
  user
  rating { (1..5).to_a.sample }
  body { Faker::Lorem.paragraph((2..10).to_a.sample) }
end