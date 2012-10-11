class ApplicationController < ActionController::Base
  protect_from_forgery
  
  private
    
  def current_cart
    Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    cart = Cart.create
    session[:cart_id] = cart.id
    return cart
  end

  def destroy_cart
    if session[:cart_id]
      cart = current_cart
      session[:cart_id] = nil
      cart.destroy
    end
  end
end
