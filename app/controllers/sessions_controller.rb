class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by_email(params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      flash[:alert] = "Invalid username or password."
      render "sessions#new"
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_url
  end
end