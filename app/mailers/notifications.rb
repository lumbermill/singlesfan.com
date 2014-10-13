class Notifications < ActionMailer::Base
  default from: "Singles Fan <noreply@www.cb.lmlab.asia>"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifications.signup.subject
  #
  def signup(master,password)
    @name = master.name
    @password = password
    @url = "http://www.cb.lmlab.asia/login"
    if Rails.env == "development"
      @url.sub!("www.","dev.")
    end

    mail to: master.email, subject: "登録完了"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifications.reset_password.subject
  #
  def reset_password(master,password)
    @name = ""
    @password = password
    @url = "http://www.cb.lmlab.asia/login"
    if Rails.env == "development"
      @url.sub!("www.","dev.")
    end

    mail to: master.email, subject: "パスワード再発行"
  end
end
