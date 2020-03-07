# frozen_string_literal: true

class CampUnitBuilder
  def initialize(root_camp_unit)
    @root_camp_unit = root_camp_unit
    @leader_builder = LeaderBuilder.new
  end

  def assignable_attributes(camp_unit_data)
    {
      starts_at: camp_unit_data.dig('linked', 'event_dates', 0, 'start_at'),
      ends_at: camp_unit_data.dig('linked', 'event_dates', 0, 'finish_at'),
      title: camp_unit_data.dig('events', 0, 'name'),
      stufe: @root_camp_unit.to_sym,
      midata_data: camp_unit_data,
      **extract_groups(camp_unit_data),
      **extract_people(camp_unit_data),
      **extract_expected_participants(camp_unit_data)
    }
  end

  def from_data(camp_unit_data, id: camp_unit_data&.dig('events', 0, 'id'))
    return unless id.present? && id != @root_camp_unit.root_id

    camp_unit = Unit.find_or_initialize_by(pbs_id: id)
    camp_unit.update(assignable_attributes(camp_unit_data))
    camp_unit
  end

  private

  def extract_expected_participants(camp_unit_data)
    stufe = @root_camp_unit.to_sym == :pta ? %i[wolf pfadi pio rover] : @root_camp_unit.to_sym

    {
      expected_participants_f: extract_expected_participant_count(stufe,    :f, from: camp_unit_data),
      expected_participants_m: extract_expected_participant_count(stufe,    :m, from: camp_unit_data),
      expected_participants_leitung_f: extract_expected_participant_count(:leitung, :f, from: camp_unit_data),
      expected_participants_leitung_m: extract_expected_participant_count(:leitung, :m, from: camp_unit_data)
    }
  end

  def extract_expected_participant_count(stufen, gender, from:)
    stufen = Array.wrap(stufen)
    stufen.inject(0) { |sum, stufe| sum + (from.dig('events', 0, "expected_participants_#{stufe}_#{gender}") || 0) }
  end

  def extract_people(camp_unit_data)
    # mapping = { al: 'abteilungsleitung', lagerleiter: 'leader', coach: 'coach' }
    mapping = { al: 'abteilungsleitung', lagerleiter: 'leader' }
    mapping.transform_values do |data_key|
      person_id   = camp_unit_data.dig('events', 0, 'links', data_key)
      person_data = camp_unit_data.dig('linked', 'people')&.find { |person| person['id'] == person_id }

      @leader_builder.from_data(person_data, id: person_id) if person_id && person_data
    end
  end

  def extract_groups(camp_unit_data)
    {
      abteilung: group_of_camp(camp_unit_data),
      kv_id: camp_unit_data.dig('linked', 'groups').find { |group| group['group_type'] == 'Kantonalverband' }&.[]('id')
    }
  end

  def group_of_camp(camp_unit_data)
    camp_unit_data.dig('linked', 'groups').find do |group|
      %w[Kantonalverband Region Abteilung].include?(group['group_type'])
    end&.[]('name')
  end
end
