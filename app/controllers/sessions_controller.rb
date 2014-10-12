class SessionsController < ApplicationController
  def new
  end

  def create
    m = Master.find_by_email(params[:email])
    if m && m.authenticate(params[:password])
      session[:master_id] = m.id
      redirect_to master_root_path, :notice => "ログインしました。"
    else
      flash.now[:alert] = "名前またはパスワードが違います。"
      flash[:notice] = "error"
      render :action => 'new'
    end
  end

  def destroy
    reset_session
    redirect_to root_path, :notice => "ログアウトしました。"
  end
end
