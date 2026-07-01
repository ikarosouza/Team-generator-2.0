class PickupGamesController < ApplicationController
  before_action :require_login
  before_action :set_pickup_game, only: %i[show edit update destroy]

  def index
    @pickup_games = current_user.pickup_games.includes(:athletes).order(start_at: :desc)
  end

  def show
  end

  def new
    @pickup_game = current_user.pickup_games.new
    load_athletes
  end

  def create
    @pickup_game = current_user.pickup_games.new(pickup_game_params)
    load_athletes

    if @pickup_game.save
      redirect_to pickup_games_path, notice: "Pelada criada com sucesso."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    load_athletes
  end

  def update
    load_athletes

    if @pickup_game.update(pickup_game_params)
      redirect_to pickup_games_path, notice: "Pelada atualizada com sucesso."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @pickup_game.destroy
    redirect_to pickup_games_path, notice: "Pelada removida com sucesso."
  end

  private

  def set_pickup_game
    @pickup_game = current_user.pickup_games.includes(:athletes).find(params[:id])
  end

  def load_athletes
    @regular_athletes = current_user.athletes.regular.order(:name)
    @guest_athletes = current_user.athletes.guests.order(:name)
  end

  def pickup_game_params
    params.require(:pickup_game).permit(:start_at, :duration, athlete_ids: [])
  end
end
