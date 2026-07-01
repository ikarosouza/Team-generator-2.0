module TeamGenerator
  class BalancedTeamsService
    Result = Struct.new(:teams, :bench, :error, keyword_init: true) do
      def success?
        error.blank?
      end
    end

    def initialize(athletes:, team_size:)
      @athletes = Array(athletes)
      @team_size = team_size.to_i
    end

    def call
      return failure("Team size deve ser maior que zero.") if @team_size <= 0
      return failure("Selecione ao menos dois times completos.") if @athletes.count < @team_size * 2

      team_count = @athletes.count / @team_size

      return failure("Não foi possível formar dois times.") if team_count < 2

      teams = Array.new(team_count) { [] }
      team_totals = Array.new(team_count, 0)
      sortable = @athletes.sort_by { |athlete| [-athlete.level.to_i, rand] }

      sortable.take(team_count * @team_size).each do |athlete|
        team_index = team_index_for(team_totals, teams)
        teams[team_index] << athlete
        team_totals[team_index] += athlete.level.to_i
      end

      Result.new(teams:, bench: sortable.drop(team_count * @team_size), error: nil)
    end

    private

    def team_index_for(team_totals, teams)
      team_totals.each_with_index.min_by { |total, index| [total, teams[index].size, rand] }.last
    end

    def failure(message)
      Result.new(teams: [], bench: [], error: message)
    end
  end
end
