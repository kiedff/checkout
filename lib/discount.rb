class Discount

  def self.all
    {
      apple: { promotion: :two_for_one, one_per_customer: false },
      pear: { promotion: :two_for_one, one_per_customer: false },
      banana: { promotion: :half_price, one_per_customer: false },
      pineapple: { promotion: :half_price, one_per_customer: true },
      mango: { promotion: :four_for_three, one_per_customer: false },
    }
  end
end