class LineItem < ActiveRecord::Base
  attr_accessible :cart_id, :product_id, :price, :product, :cart, :quantity
  belongs_to :order
  belongs_to :product
  belongs_to :cart

  def total_price
    price * quantity
  end

end
