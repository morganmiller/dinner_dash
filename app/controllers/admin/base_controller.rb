class Admin::BaseController < ApplicationController
  before_action :require_admin

  private
  def require_admin
    render status: :forbidden, file: "/public/404" unless current_admin?
  end
end
