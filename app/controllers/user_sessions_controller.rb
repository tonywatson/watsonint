class UserSessionsController < ApplicationController
  def new
      @page_title = "Account Login"
      @user_session = UserSession.new
    end

    def create
      @user_session = UserSession.new(params[:user_session])
      if @user_session.save
        redirect_back_or_default params[:return_to] || root_path
        return
      else
        render :action => 'new'
      end
    end

    def destroy
      current_user_session.destroy unless current_user_session.blank?
      redirect_to root_path and return
    end
end
