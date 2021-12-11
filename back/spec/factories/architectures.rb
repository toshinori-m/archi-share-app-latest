FactoryBot.define do
  factory :architecture do
    name { 'a' * 15 }
    prefecture { '北海道' }
    address { 'a' * 30 }
    construction { '木造' }
    designer { 'a' * 10 }
    above_floor { '1階' }
    under_floor { '地下1階' }
  end
end
