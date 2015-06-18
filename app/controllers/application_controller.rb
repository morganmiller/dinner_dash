class ApplicationController < ActionController::Base
  include ApplicationHelper

  protect_from_forgery with: :exception
  
  before_action :load_cart


  helper_method :current_user

  def load_cart
    @cart = Cart.new(session[:cart])
  end
end
