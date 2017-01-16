class RelationshipsController < ApplicationController

  def index
    @title = params[:relation]
    @user = User.find_by id: params[:user_id]
    if @user
      @users = @user.send(@title).paginate page: params[:page]
      render "users/show_follow"
    else
      flash[:danger] = "can't found user"
      redirect_to root_path
    end
  end


  def create
    @user = User.find_by id: params[:followed_id]
    if @user
      current_user.follow @user
      @relationship = current_user.active_relationships
        .find_by followed_id: @user.id
      unless @relationship
        flash[:danger] = "Not user follow"
        redirect_to root_url
      end
      respond_to do |format|
        format.html {redirect_to @user}
        format.js
      end
    else
      flash[:danger] = "can't found user follow"
      redirect_to root_path
    end
  end

  def destroy
    relationship = Relationship.find_by(id: params[:id]).followed
    if relationship
      @relation = current_user.active_relationships.build
      current_user.unfollow relationship
      @user = User.find_by id: relationship.id
      unless @user
        flash[:danger] = "Can not found user"
        redirect_to root_url
      end
      respond_to do |format|
        format.html {redirect_to @user}
        format.js
      end
    else
      flash[:danger] = "Not followed user to unfollow"
      redirect_to root_url
    end
  end
end
