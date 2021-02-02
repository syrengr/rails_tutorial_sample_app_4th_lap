FactoryBot.define do
  factory :user do
    name { "TestUser" }
    sequence(:email) { |n| "test#{n}@example.com" }
    password { "foobar" }
    password_confirmation { "foobar" }

    trait :admin do
      admin { true }
    end

    trait :no_activated do
      activated { false }
      activated_at { nil }
    end
  end
end
