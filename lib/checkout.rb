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
    0
  end

  def basket
    @basket ||= Array.new
  end
end
