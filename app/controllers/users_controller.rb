class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  
  # プロフィール表示
  def profile
  end
  
  # プロフィール編集フォーム
  def edit_profile
  end
  
  # プロフィール更新処理
  def update_profile
    if params[:user][:avatar].present?
      @user.avatar.attach(params[:user][:avatar])
    end
    
    if @user.update(profile_params.except(:avatar))
      redirect_to users_profile_path
    else
      render :edit_profile
    end
  end
  
  # アカウント表示
  def account
  end
  
  private
  
  # 現在のユーザーを設定
  def set_user
    @user = current_user
  end
  
  # プロフィール用パラメータ
  def profile_params
    params.require(:user).permit(:username, :avatar, :bio)
  end
  
  # アカウント用パラメータ
  def account_params
    params.require(:user).permit(:email, :password, :password_confirmation, :current_password)
  end
end