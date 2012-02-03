class ClassroomController < ApplicationController
  before_filter :authenticate_user!
  protect_from_forgery :except => :send_text 

  ACCOUNT_SID = "ACa1ea1f6ff1ff670cab52e982a0df35f9"
  ACCOUNT_TOKEN = "8f8c318d4c8ebdb71c53b0cbc140c9e5"
  API_VERSION = '2010-04-01'
  CALLER_ID = "415-599-2671"
  CALLER_PIN = "1804-0134"

  protect_from_forgery :except => :next 

  def show
    @user = User.find_by_uni(params[:id])
    opentok = OpenTok::OpenTokSDK.new OT_key, OT_secret
    @token = opentok.generate_token :session_id => @user.session_id
    @s_id=@user.session_id

    w=WaitLine.new()
    w.user_id=current_user.id
    w.username=current_user.uni
    w.classroom_id=@user.id
    w.status=1
    w.save()
    #flash[:notice]="Welcome"

  end

  def send_text
    @user = User.find_by_uni(params[:recipient_id])
 	 if @user.number && params[:recipient_id] != params[:sender_id]
 	  @client = Twilio::REST::Client.new ACCOUNT_SID, ACCOUNT_TOKEN
 	  t= @client.account.sms.messages.create(
      :from => CALLER_ID,
      :to => @user.number,
      :body => 'Your students need you! Come online!'
    )
  end
 	 # t = {
 	 #     'From' => CALLER_ID,
 	 #     'To' => '3477463543',
 	 #     'Body' => ("#{CALLER_PIN} Your students need you! Come online!")
 	 #     }
 	 
  	begin
  	  account = Twilio::RestAccount.new(ACCOUNT_SID, ACCOUNT_TOKEN)
   		 resp = account.request("/#{API_VERSION}/Accounts/#{ACCOUNT_SID}/SMS/Messages",
                   'GET',
                   t)
    	resp.error! unless resp.kind_of? Net::HTTPSuccess

  	rescue StandardError => bang
      redirect_to :back
    	return
 	end
    redirect_to :back
  end

  def next
    name_channel="presence-channel-"+current_user.uni
    Pusher[name_channel].trigger('thing_create', {email:'test'})
    render :text => "next user"
  end

end
