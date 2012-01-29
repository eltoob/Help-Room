class ClassroomController < ApplicationController
  before_filter :authenticate_user!
  def show
    @user=User.find_by_uni(params[:id])
   end

    opentok = OpenTok::OpenTokSDK.new OT_key, OT_secret
    @token = opentok.generate_token :session_id => @user.session_id
    @s_id=@user.session_id
  end

end
