class AthletesController < ApplicationController
  before_action :require_login
  before_action :set_athlete, only: %i[show edit update destroy]

  def index
    @regular_athletes = current_user.athletes.regular.order(:name)
    @guest_athletes = current_user.athletes.guests.order(:name)
  end

  def show
  end

  def new
    @athlete = current_user.athletes.new
  end

  def create
    @athlete = current_user.athletes.new(athlete_params)

    if @athlete.save
      redirect_to athletes_path, notice: "Atleta cadastrado com sucesso."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @athlete.update(athlete_params)
      redirect_to athletes_path, notice: "Atleta atualizado com sucesso."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @athlete.destroy
    redirect_to athletes_path, notice: "Atleta removido com sucesso."
  end

  private

  def set_athlete
    @athlete = current_user.athletes.find(params[:id])
  end

  def athlete_params
    params.require(:athlete).permit(:name, :level, :guest)
  end
end
