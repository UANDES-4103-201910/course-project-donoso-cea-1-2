class ProfileController < ApplicationController
  def userprofile
      @posts = Post.all
    end

end
