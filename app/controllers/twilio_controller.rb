require "twiliolib.rb"

ACCOUNT_SID = "ACe33808a9c8ac4884aebafa7ddeba5322"
ACCOUNT_TOKEN = "e085edd0f5deb9ea6b5a04a954b3ead8"

API_VERSION = '2010-04-01'

CALLER_ID = "415-599-2671"

CALLER_PIN = "5781-1497"

def send_sms
  t = {
    'From' => CALLER_ID,
    'To' => "301-233-7647",
    'Body' => ("#{CALLER_PIN} Twilio rocks!")
  }

  begin
    account = Twilio::RestAccount.new(ACCOUNT_SID, ACCOUNT_TOKEN)
    resp = account.request("/#{API_VERSION}/Accounts/#{ACCOUNT_SID}/SMS/Messages",
                   'POST',
                   t)
    resp.error! unless resp.kind_of? Net::HTTPSuccess

  rescue StandardError => bang
    redirect_to({ :action => :index, 'msg' => "Error #{ bang }" })
    return
  end

  redirect_to({ :action => :index, 'msg' => "Sms sent."})

end
end
