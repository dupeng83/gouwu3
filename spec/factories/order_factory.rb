FactoryGirl.define do
  factory :order do
    total_price 100
  end

  trait :unpaid do
    paid false
  end

  trait :paid do
    paid true
  end

  trait :boc do
    pay_method "中国银行"
  end

  trait :kuaidi do
    deliver_method "快递"
  end
end