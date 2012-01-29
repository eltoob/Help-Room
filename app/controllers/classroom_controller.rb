class ClassroomController < ApplicationController
  before_filter :authenticate_user!
  def show
    @user=User.find_by_uni(params[:id])
    
  end

end
