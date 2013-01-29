class UserMailer < ActionMailer::Base
  default :from => "Snippet Monkey"
  def send_activation_mail(user, activation_path, root_url)
    begin
      @user = user
      @account_activation_link = "http://#{root_url}#{activation_path}"
      @application_root_url = "http://#{root_url}"
      deliver_email = mail(:to => @user.email,
                           :subject => "Account activation Email from Snippet Monkey",
                           :content_type => "text/html") do |format|
                             format.html { render "user_mailer/account_activation"}
                           end
      deliver_email.deliver
      return true
    rescue Exception => e
      return false
    end
  end
end
