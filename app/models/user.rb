class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :lockable, :timeoutable and :omniauthable

  before_save :create_string, :create_uni, :auto_confirm, :create_opentok_session

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name,  :ta, :session_id, :random_string

  validates_presence_of :name
  validates_uniqueness_of :name, :case_sensitive => false

  private

    def create_string
      self.random_string = Devise.friendly_token[0,20]
    end

    def create_uni
      self.uni = self.email.split("@").first
    end
    
    def create_opentok_session
      @opentok = OpenTok::OpenTokSDK.new OT_key, OT_secret
      self.session_id=@opentok.create_session
      puts '----------'
      puts session_id
    end
    
    def auto_confirm
      if Rails.env.development?
        self.confirmed_at=Time.now()
      end
    end
    

end
