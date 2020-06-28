# frozen_string_literal: true

# CRUD for users
class UsersController < ApplicationController
  # Use KnockKnock to make sure the current_user is authenticated before completing request.
  skip_before_action :authenticate_user, only: %i[create]
  before_action :authorize, only: %i[update destroy]

  def index
    json_response(User.all)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      json_response(@user.authorization_jwt_token, :created)
    else
      record_invalid
    end
  end

  def update
    @user = User.find(params[:id])
    json_response(@user) if @user.update!(user_params)
  end

  def destroy
    @user = User.find(params[:id])
    head :no_content if @user.destroy!
  end

  def show
    json_response(current_user)
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end

  def authorize
    unauthorized unless current_user.id.to_s == params[:id].to_s
  end
end
