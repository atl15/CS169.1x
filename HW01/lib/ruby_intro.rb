# When done, submit this entire file to the autograder.

# Part 1

def sum arr
  arr.inject(0, :+)
end

def max_2_sum arr
  arr.max(2).inject(0, :+)
end

def sum_to_n? arr, n
  arr.combination(2).any? { |a, b| a + b == n }
end

# Part 2

def hello(name)
  "Hello, #{name}"
end

def starts_with_consonant? s
  s =~ /^[^aeiou\d\W]/i
end

def binary_multiple_of_4? s
  s =~ /^(1|0)+$/ && s.to_i(2) % 4 == 0    
end

# Part 3

class BookInStock
  def initialize(isbn, price)
    raise ArgumentError if isbn.empty? || price <= 0
    @isbn = isbn
    @price = price
  end

  attr_accessor :isbn, :price

  def price_as_string
    "$#{'%.2f' % self.price}"
  end
end
