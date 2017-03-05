FactoryGirl.define do
  factory :user, class: 'Users' do
    name "Test User"
    email "test@example.com"
    password "please123"
  end
end
