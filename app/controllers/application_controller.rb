class ApplicationController < ActionController::Base
  #protect_from_forgery
=begin
  This function is used to generate random number. 
=end
  def get_new_snippetlocation
    require 'securerandom'
    "#{SNIPPET_FOLDER}#{SecureRandom.urlsafe_base64(32)}#{Time.now.to_s}.jpg"
  end
  
=begin
  This function is used to clear all flash. 
=end 
  def clear_all_flash
    flash[:notice] = flash[:alert] = flash[:error] = nil
  end 
  
 
=begin
  This function is used set the confirmation token.
  Used for creating confirmation token on user creation.
=end  
  def set_confirmation_token
    SecureRandom.hex(16)
  end
  
  helper_method :yt_client

  
  def yt_client
    @yt_client ||= YouTubeIt::Client.new(:username => YouTubeITConfig.username , :password => YouTubeITConfig.password , :dev_key => YouTubeITConfig.dev_key)
  end
  
end
