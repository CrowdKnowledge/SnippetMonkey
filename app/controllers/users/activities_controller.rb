class Users::ActivitiesController < ApplicationController
  before_filter :authenticate_user!
  
=begin
  This function is used to upload user image. 
=end
  def upload_avatar
    begin
      current_user.avatar = params[:user_image]
      current_user.save
    rescue Exception => e
      flash[:error] = e.message
    end
    if params[:action] == "upload_avatar"
      redirect_to users_profile_path 
    else
      redirect_to root_url
    end
  end
  
  
  def change_profile_info
    begin
      current_user.update_attributes!(:first_name => params[:first_name],
                                      :last_name => params[:last_name],
                                      :address => params[:address]) 
    rescue Exception => e
      flash[:error] = e.message
    end
    redirect_to users_profile_path
  end
  
  def change_password
    begin
      current_user.update_attributes!(:password => params[:password]) 
      redirect_to users_profile_path
    rescue Exception => e
      flash[:error] = e.message
    end 
    redirect_to users_profile_path   
  end
end
