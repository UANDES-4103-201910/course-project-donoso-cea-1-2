class AdminController < ApplicationController
  def admins
  end

  def index
    @users = User.all
  end
end
