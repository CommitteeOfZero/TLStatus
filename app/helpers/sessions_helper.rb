module SessionsHelper
  def current_user
    @current_user ||= User.find_by(discord_uid: session[:discord_uid])
    session.delete(:discord_uid) if @current_user.nil?
    return @current_user
  end
  
  def logged_in?
    !!current_user
  end
  
  def login(user)
    session[:discord_uid] = user.discord_uid
  end
  
  def logout
    @current_user = nil
    session.delete(:discord_uid)
  end
end
