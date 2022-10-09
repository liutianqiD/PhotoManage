class SessionsController < ApplicationController
  before_action :require_login, only: [:destroy]
  def new
  end

  def create

    if params[:session][:email].blank? & params[:session][:password].blank?
      flash[:danger] = "・ユーザーIDを入力してください。</br>・パスワードを入力してください。"
      redirect_to login_url
    else

      user = User.find_by(email: params[:session][:email].downcase)
      if user && user.authenticate(params[:session][:password])
        log_in user
        redirect_to root_url
      else
        flash[:danger] = "・ユーザーIDとパスワードが一致するユーザーが存在しない。"
        redirect_to login_url
      end
    end

end


  def destroy
    log_out if logged_in?
    redirect_to root_url
  end


end
