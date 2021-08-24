class Checkout
  require_relative 'discount'

  attr_reader :prices
  private :prices

  def initialize(prices)
    @prices = prices
  end

  def scan(item)
    basket << item.to_sym
  end

  def total
    subtotal = 0
    discount = 0
    total = 0

    basket.inject(Hash.new(0)) { |items, item| items[item] += 1; items }.each do |item, count|
      subtotal += prices.fetch(item) * count
      discount += calculate_discount(item, count)
    end

    subtotal - discount
  end

  private

  def calculate_discount(item, count)
    discount = Discount.all[item]
    return 0 unless discount
    send(discount[:promotion], item, count, discount[:one_per_customer]) if respond_to? discount[:promotion], true
  end

  def two_for_one(item, count, apply_once)
    if count >= 2
      count = 2 if apply_once
      prices.fetch(item) * (count / 2)
    else
      0
    end 
  end

  def half_price(item, count, apply_once)
    count = 1 if apply_once
    (prices.fetch(item) * count) / 2
  end

  def basket
    @basket ||= Array.new
  end
end
