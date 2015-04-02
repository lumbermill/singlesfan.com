class SessionsController < ApplicationController
  def new
    @title = "ログイン"
  end

  def create
    m = Master.find_by_email(params[:email])
    p = params[:password]

    if m && p != PASSWORD_NULL && m.authenticate(p)
      session[:master_id] = m.id
      m.last_accessed_at = DateTime.now.to_s
      m.save
      redirect_to for_master_root_path, :notice => "ログインしました。"
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
