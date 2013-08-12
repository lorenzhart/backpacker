### app/models/user.rb
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :trackable, :omniauthable
  has_many :questions
  has_many :answers
  has_many :send_paths, :class_name => 'Path', :foreign_key => 'from_user_id'
  has_many :received_paths, :class_name => 'Path', :foreign_key => 'to_user_id'
  has_many :received_questions, :source => :to_user, :through => :received_paths

  # Setup accessible (or protected) attributes for your model
  #attr_accessible :email, :password, :name, :provider, :uid
  # attr_accessible :title, :body

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.create(name:auth.extra.raw_info.name,
                         provider:auth.provider,
                         uid:auth.uid,
                         email:auth.info.email,
                         password:Devise.friendly_token[0,20],
                         token:auth.credentials.token
                         )
    end
    user
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  
  def facebook_friends
      access_token = self.token
      @graph = Koala::Facebook::API.new(access_token)
      friends = @graph.get_connections("me", "friends")
      return friends
  end
end