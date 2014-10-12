class SessionsController < ApplicationController
  def new
  end

  def create
    b = Barkeeper.find_by_email(params[:email])
    if b && b.authenticate(params[:password])
      sign_in b
      redirect_to for_admins_path, :notice => "ログインしました。"
    else
      flash.now[:alert] = "名前またはパスワードが違います。"
      flash[:notice] = "error"
      render :action => 'new'
    end
  end

  def destroy
    sign_out
  end
end
