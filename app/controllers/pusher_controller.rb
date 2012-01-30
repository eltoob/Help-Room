class PusherController < ApplicationController
  protect_from_forgery :except => :auth # stop rails CSRF protection for this action
  def auth
    if current_user
      response = Pusher[params[:channel_name]].authenticate(params[:socket_id], {
              :user_id => current_user.id, # => required
              :user_info => { # => optional - for example
                :name => current_user.name,
                :email => current_user.email,
                :arrived_at =>Time.now().to_i
              }
            })
      render :json => response
    else
      render :text => "Not authorized", :status => '403'
    end
  end
end
