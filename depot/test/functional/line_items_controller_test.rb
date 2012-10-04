require 'test_helper'

class LineItemsControllerTest < ActionController::TestCase
  setup do
    @line_item = line_items(:one)
    @double_item = line_items(:double)
    session[:cart_id] = carts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:line_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create line_item" do
    assert_difference('LineItem.count') do
      post :create, :product_id => products(:two).id
    end

    assert_redirected_to store_path
  end

  test "should create line_item via ajax" do
    assert_difference('LineItem.count') do
      xhr :post, :create, :product_id => products(:two).id
    end

    assert_response :success
    assert_select_jquery :html, '#cart' do 
      assert_select 'tr#current_item td', /MyString/
    end
  end

  test "should show line_item" do
    get :show, :id => @line_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @line_item
    assert_response :success
  end

  test "should update line_item" do
    put :update, :id => @line_item, :line_item => { :cart_id => @line_item.cart_id, :product_id => @line_item.product_id }
    assert_redirected_to line_item_path(assigns(:line_item))
  end

  test "should destroy line_item" do
    assert_difference('LineItem.count', -1) do
      delete :destroy, :id => @line_item
    end

    assert_redirected_to cart_path @line_item.cart
  end
  
  test "should decrease line_item quantity" do
    assert_difference('LineItem.count', 0) do
      delete :destroy, :id => @double_item
    end
    assert 1, @double_item.reload.quantity
    assert_redirected_to cart_path @double_item.cart
  end
end
