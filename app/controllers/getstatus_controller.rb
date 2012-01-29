class GetstatusController < ApplicationController
  protect_from_forgery :except => :index 
  before_filter :authenticate_user!
  def index
    @user=User.find_by_uni(params[:id])
    @total_list=WaitLine.where("status=1 AND user_id=#{@user.id}").order("updated_at ASC")
    render :json => @total_list
  end

end
