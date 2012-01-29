class ClassroomController < ApplicationController
  before_filter :authenticate_user!
  def show
    puts 'yeasss'
    @user=User.find_by_uni(params[:id])
    opentok = OpenTok::OpenTokSDK.new OT_key, OT_secret
    @token = opentok.generate_token :session_id => @user.session_id
    @s_id=@user.session_id
    w=WaitLine.new()
    w.user_id=current_user.id
    w.classroom_id=@user.id
    w.status=1
    w.save()
    puts 'here we go!!!'
  end

end
