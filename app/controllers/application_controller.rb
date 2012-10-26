class ApplicationController < ActionController::Base
  protect_from_forgery
  def user_session
  	@user_session ||= UserSession.new(session)
  end
	helper_method :user_session
  #session[:user_id] = @current_user.id
  #User.find(session[:user_id])
  #session[:user] = @user
  #
end
