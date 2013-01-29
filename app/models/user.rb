class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, 
         :token_authenticatable, :confirmable, :lockable, :timeoutable,
         :omniauthable
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, 
                  :password, 
                  :password_confirmation, 
                  :remember_me,
                  :first_name,
                  :last_name,
                  :confirmation_token, 
                  :confirmation_sent_at, 
                  :confirmation_status,
                  :confirmed_at,
                  :latitude, 
                  :longitude,
                  :address,
                  :current_location_id,
                  :last_sign_in_ip,
                  :provider, :uid
                  
  validates :first_name, :presence => true
  has_many :comments
  has_many :snippets
  # attr_accessible :title, :body
  
# def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
  # user = User.where(:provider => auth.provider, :uid => auth.uid).first
  # unless user
    # user = User.create(name:auth.extra.raw_info.name,
                         # provider:auth.provider,
                         # uid:auth.uid,
                         # email:auth.info.email,
                         # password:Devise.friendly_token[0,20]
                         # )
  # end
  # user
# end


def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
  user = User.where(:provider => auth.provider, :uid => auth.uid).first
  unless user
    user = User.create(  provider:auth.provider,
                         uid:auth.uid,
                         email:auth.info.email,
                         first_name:auth.info.first_name,
                         last_name:auth.info.last_name,
                         confirmation_status: true,
                         confirmed_at: Time.now,
                         confirmation_sent_at: Time.now,
                         password:Devise.friendly_token[0,20]
                         )

    user.ensure_authentication_token!
    #added extra to create authentication token for user
  end
  user
end


def self.from_omniauth(auth)
  where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
    user.provider = auth.provider
    user.uid = auth.uid
    user.oauth_token = auth.credentials.token
    user.oauth_expires_at = Time.at(auth.credentials.expires_at)
    user.save!
  end
end
 

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
  
  def full_name
    "#{first_name} #{last_name}"
  end
end
