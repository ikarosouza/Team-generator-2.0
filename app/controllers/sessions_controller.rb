class SessionsController < ApplicationController
  skip_before_action :require_login

  def new; end

  def create
    user = User.authenticate_by(email: session_params[:email].to_s.downcase, password: session_params[:password])

    if user
      session[:user_id] = user.id
      redirect_to root_path, notice: "Login realizado com sucesso."
    else
      flash.now[:alert] = "Email ou senha inválidos."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    reset_session
    redirect_to new_session_path, notice: "Sessão encerrada."
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
