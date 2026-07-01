class TeamGeneratorsController < ApplicationController
  before_action :require_login

  def new
    load_athletes
    latest_generation = current_user.team_generations.order(created_at: :desc).first
    @selected_athlete_ids = latest_generation&.selected_athlete_ids || selected_athlete_ids
    @team_size = latest_generation&.team_size || team_size_param
  end

  def create
    load_athletes
    @team_size = team_size_param
    @selected_athlete_ids = selected_athlete_ids
    selected_athletes = current_user.athletes.where(id: @selected_athlete_ids).order(guest: :asc, name: :asc)
    result = TeamGenerator::BalancedTeamsService.new(athletes: selected_athletes, team_size: @team_size).call

    if result.success?
      store_generation(selected_athletes, result)
      redirect_to team_generator_path, notice: "Times gerados com sucesso."
    else
      flash[:alert] = result.error
      redirect_to new_team_generator_path(team_generator: { athlete_ids: @selected_athlete_ids, team_size: @team_size })
    end
  end

  def show
    data = latest_generation

    if data.blank?
      redirect_to new_team_generator_path, alert: "Gere os times primeiro."
      return
    end

    @team_size = data.team_size
    @selected_athlete_ids = data.selected_athlete_ids
    @teams = Array(data.teams_payload)
    @bench = Array(data.bench_payload)
  end

  private

  def load_athletes
    @regular_athletes = current_user.athletes.regular.order(:name)
    @guest_athletes = current_user.athletes.guests.order(:name)
  end

  def selected_athlete_ids
    Array(params.dig(:team_generator, :athlete_ids)).reject(&:blank?).uniq
  end

  def team_size_param
    value = params.dig(:team_generator, :team_size).to_i
    value.positive? ? value : 4
  end

  def store_generation(selected_athletes, result)
    current_user.team_generations.create!(
      team_size: @team_size,
      selected_athlete_ids: selected_athletes.map { |athlete| athlete.id.to_s },
      teams_payload: result.teams.map { |team| snapshot_athletes(team) },
      bench_payload: snapshot_athletes(result.bench)
    )
  end

  def latest_generation
    @latest_generation ||= current_user.team_generations.order(created_at: :desc).first
  end

  def snapshot_athletes(athletes)
    athletes.map do |athlete|
      {
        "id" => athlete.id,
        "name" => athlete.name,
        "level" => athlete.level,
        "guest" => athlete.guest
      }
    end
  end
end
