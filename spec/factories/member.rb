FactoryBot.define do
  factory :member do
   name { FFaker::Lorem.word }
   email { FFaker::Internet.email }
   campaign
  end
end
