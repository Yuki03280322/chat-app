class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end

#2 信頼できるuserですか？＝ログインしていないのなら、ログイン画面へ
#3 deviseControllerを動かしますか？

#7 ユーザー登録の時、nameカラムを追加することを許可する