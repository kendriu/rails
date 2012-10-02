require 'test_helper'

class CartTest < ActiveSupport::TestCase
  def setup
    @cart = Cart.new
    @book_one = products(:one)
    @book_two = products(:ruby)
  end
  test "add unique product" do
     @cart.add_product(@book_one).save!
     assert 1, @cart.line_items.size
     assert @book_one.price, @cart.line_items[0].price

     @cart.add_product(@book_two).save!

     assert 2, @cart.line_items.size
     assert @book_one.price + @book_two.price, @cart.total_price
  end

  test "add duplicate product" do
     @cart.add_product(@book_one).save!
     @cart.add_product(@book_one).save!
     
     assert 1, @cart.line_items.size
     assert 2, @cart.line_items[0].quantity
     assert 2 * @book_one.price, @cart.total_price
  end
end
