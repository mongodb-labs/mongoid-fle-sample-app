module Admin
  class UsersController < ApplicationController
    def index
      @users = User.all
    end

    def destroy
      @user = User.find(params[:id])
      @user.destroy
      redirect_to admin_users_path
    end
  end
end
