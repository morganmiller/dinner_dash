class ApplicationController < ActionController::Base
  include ApplicationHelper

  protect_from_forgery with: :exception

  before_action :load_cart

  helper_method :current_user
  helper_method :current_admin?

  def load_cart
    @cart = Cart.new(session[:cart])
  end

  def current_admin?
    current_user && current_user.admin?
  end    
end
