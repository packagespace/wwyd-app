class UsersController < ApplicationController
  allow_unauthenticated_access only: %i[new create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      Solve.where(id: session[:solve_ids] || []).update_all(user_id: @user.id)
      session.delete(:solve_ids)
      redirect_to new_session_path, notice: "Account created successfully!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.expect(user: [ :email_address, :password, :password_confirmation ])
  end
end
