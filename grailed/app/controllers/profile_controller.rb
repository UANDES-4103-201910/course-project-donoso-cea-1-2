class ProfileController < ApplicationController
  def userprofile
      @posts = Post.all
      @comments = Comment.all
    end

end
