class ApplicationController < ActionController::Base
  protect_from_forgery
  
=begin
  This function is used to generate random number. 
=end
  def get_new_snippetlocation
    require 'securerandom'
    "#{SNIPPET_FOLDER}#{SecureRandom.urlsafe_base64(32)}#{Time.now.to_s}.jpg"
  end

end
