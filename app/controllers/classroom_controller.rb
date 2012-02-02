class ClassroomController < ApplicationController
  before_filter :authenticate_user!
  protect_from_forgery :except => :next 
  def show
    @user=User.find_by_uni(params[:id])
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
  def next
    name_channel="presence-channel-"+current_user.uni
    Pusher[name_channel].trigger('thing_create', {email:'test'})
    render :text => "next user"
    puts 'test'
  end

end
