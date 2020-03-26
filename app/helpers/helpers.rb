class Helpers
  def self.is_logged_in?(session)
    User.exists?(session[:uid])
  end

  def self.current_user(session)
    User.find_by(id: session[:uid])
  end

end
