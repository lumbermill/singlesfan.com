class Notifications < ActionMailer::Base
  default from: "Singles Fan <noreply@"+DOMAIN+">"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifications.signup.subject
  #
  def signup(master,password)
    @name = master.name
    @password = password
    @url = "http://www."+DOMAIN+"/login"
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
    @url = "http://www."+DOMAIN+"/login"
    if Rails.env == "development"
      @url.sub!("www.","dev.")
    end

    mail to: master.email, subject: "パスワード再発行"
  end

  # フォームを送信したユーザに返す
  def confirm_application(inquiry)
    @name = inquiry.name
    @email = inquiry.email
    @date = inquiry.date
    @memo = inquiry.memo
    mail to: inquiry.email, subject: "[自動送信]説教バー申込受付"
  end

  # 申込があったことを通知
  def notify_application(inquiry)
    @name = inquiry.name
    @email = inquiry.email
    @date = inquiry.date
    @memo = inquiry.memo
    # to singles.5th@gmail.com
    mail to: "singles.5th@gmail.com", subject: "説教バー申込受付"
  end
end
