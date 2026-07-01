class PagesController < ApplicationController
  skip_before_action :require_login, only: :home

  def home
    if logged_in?
      @athletes_count = current_user.athletes.count
      @pickup_games_count = current_user.pickup_games.count
      @team_generator_ready = current_user.athletes.count >= 8
    end
  end
end
