class UsersController < ApplicationController
  allow_unauthenticated_access only: %i[new create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if User.exists?(email_address: @user.email_address)
      @user.errors.add(:email_address, "is already taken")
      return render :new, status: :unprocessable_entity
    end

    if @user.save
      transfer_session_solves_to_user
      start_new_session_for @user
      redirect_to after_authentication_url, notice: "Account created successfully!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email_address, :password, :password_confirmation)
  end
  
  # Transfer any solves stored in the session to the newly created user
  def transfer_session_solves_to_user
    return unless session[:solve_ids].present?
    
    Solve.where(id: session[:solve_ids]).update_all(user_id: @user.id)
    session.delete(:solve_ids)
  end
end
