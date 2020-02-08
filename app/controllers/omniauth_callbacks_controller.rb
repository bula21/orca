# frozen_string_literal: true

class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_forgery_protection
  before_action :set_user, only: %i[developer openid_connect]

  def developer
    sign_in_and_redirect @user, event: :authentication unless @user.persisted?
  end

  def openid_connect
    sign_in_and_redirect @user, event: :authentication unless @user.persisted?
  end

  def failure
    redirect_to root_path
  end

  private

  def set_user
    dasdasda
    @user = User.from_omniauth(request.env['omniauth.auth'])
  end
end
