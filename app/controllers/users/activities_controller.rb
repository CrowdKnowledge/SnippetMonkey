class Users::ActivitiesController < ApplicationController
  before_filter :authenticate_user!, :only => [:upload_avatar, :change_profile_info, :change_password]
  
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
  
=begin
  This function is used to edit the profile information. 
=end
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
 
=begin
  This function is used to change the password. 
=end  
  def change_password
    begin
      current_user.update_attributes!(:password => params[:password]) 
      redirect_to users_profile_path
    rescue Exception => e
      flash[:error] = e.message
    end 
    redirect_to users_profile_path   
  end
  
=begin
  This function is used to recover password. 
=end
  def recover_password
    begin
      @user = User.find_by_email(params[:email])
      if @user
        unless @user.confirmation_status
          flash[:error] = "Please activate your account first using the activation link sent to your email."
        end
        UserMailer.send_password_recovery_mail(@user,
                                               edit_password_via_recovery_path(@user.confirmation_token),
                                               request.host_with_port)  
        flash[:info] = "We have sent the password to your email."
      else
        flash[:info] = "We have sent the password to your email."
      end
    rescue Exception => e
      flash[:info] = "We have sent the password to your email."
    end
    redirect_to root_path
  end
  
=begin
  This function is used to recover password. 
=end
  def edit_password_via_recovery
    @user = User.find_by_confirmation_token(params[:id])
    render "users/passwords/edit" 
  end
  
=begin
  This function is used to update password. 
=end
  def update_password_via_recovery
    begin
      @user = User.find(params[:id])
      if @user.update_attributes!(:password => params[:password])
        flash[:success] = "Your password was updated successfully!"
        sign_in @user, :bypass => true
      end
    rescue Exception => e
      flash[:account_activation_fail] = e.message
    end
    redirect_to edit_password_via_recovery_path(@user.confirmation_token)
  end
  
=begin
  This function is used to render the image 
=end
  def render_avatar_image
    path = "#{Rails.root}/public/user_avatars/#{params[:image]}.#{params[:format]}"
    send_file(path, :disposition => 'inline')
  end
end
