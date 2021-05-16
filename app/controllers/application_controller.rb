class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery  with: :exception # See ActionController::RequestForgeryProtection for details

  private

  def current_admin_session
    return @current_admin_session if defined?(@current_admin_session)
    @current_admin_session = AdminSession.find
  end

  def current_admin
    return @current_admin if defined?(@current_admin)
    @current_admin = current_admin_session && current_admin_session.admin
  end

  helper_method :current_admin_session, :current_admin
end