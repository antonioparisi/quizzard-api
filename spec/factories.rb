FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "email#{n}@quizzard.com" }
    name 'Antonio'
    lastname 'Parisi'
    picture 'http://foo/img'
    access_token 'test'
  end

  factory :question do
    sequence(:title) { |n| "question #{n}" }
    correct_number 1
  end

  factory :answer do
    sequence(:title) { |n| "answer #{n}" }
    association(:question)
  end
end
