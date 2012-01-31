class ClassroomController < ApplicationController
  before_filter :authenticate_user!

  ACCOUNT_SID = "ACe33808a9c8ac4884aebafa7ddeba5322"
  ACCOUNT_TOKEN = "e085edd0f5deb9ea6b5a04a954b3ead8"

  API_VERSION = '2010-04-01'

  CALLER_ID = "415-599-2671"

  CALLER_PIN = "5781-1497"

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

  end

  def send_text
    @user = User.find_by_uni(params[:id])
 	 t = {
    'From' => CALLER_ID,
    'To' => @user.number,
    'Body' => ("#{CALLER_PIN} Your students need you! Come online!")
 	 }

  	begin
  	  account = Twilio::RestAccount.new(ACCOUNT_SID, ACCOUNT_TOKEN)
   		 resp = account.request("/#{API_VERSION}/Accounts/#{ACCOUNT_SID}/SMS/Messages",
                   'POST',
                   t)
    	resp.error! unless resp.kind_of? Net::HTTPSuccess

  	rescue StandardError => bang
      redirect_to :back
    	return
 	end
    redirect_to :back
  end

end
