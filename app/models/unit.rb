# frozen_string_literal: true

class Unit < ApplicationRecord
  RootCampUnit = Struct.new(:to_sym, :root_id) { delegate :to_s, to: :to_sym }
  ROOT_CAMP_UNITS = {
    wolf: RootCampUnit.new(:wolf, 1328),
    pfadi: RootCampUnit.new(:pfadi, 1328),
    pio: RootCampUnit.new(:pio, 1328),
    rover: RootCampUnit.new(:rover, 1328),
    pta: RootCampUnit.new(:pta, 1328)
  }.freeze

  belongs_to :al, class_name: 'Leader', inverse_of: :al_units, optional: true
  belongs_to :lagerleiter, class_name: 'Leader', inverse_of: :lagerleiter_units, optional: true
  # belongs_to :coach, class_name: 'Leader', inverse_of: :coach_units, optional: true
  validates :title, presence: true

  YEAR = 2021
  KVS = [
    166, # 'Pfadi St. Gallen - Appenzell',
    638, # 'AS Fribourgeois',
    1018, # 'AS Genevois',
    911, # 'AS Jurassienne',
    994, # 'AS Valaisan',
    3, # 'Pfadi Kanton Solothurn',
    4, # 'Pfadi Kanton Bern',
    85, # 'Pfadi Uri',
    142, # 'Pfadi Kanton Schwyz',
    161, # 'Pfadi Glarus',
    167, # 'Battasendas Grischun',
    4691, # 'Pfadi Aargau',
    631, # 'Pfadi Kanton Schaffhausen',
    237, # 'Pfadi Kanton Zug',
    179, # 'Pfadi Luzern',
    299, # 'Pfadi Region Basel',
    993, # 'Pfadi Thurgau',
    187, # 'Pfadi Unterwalden',
    238, # 'Scoutismo Ticino',
    880, # 'Scouts Neuchatelois',
    513, # 'Scouts Vaudois',
    1145 # ' Pfadi Zueri'
  ].freeze

  enum stufe: ROOT_CAMP_UNITS.dup.transform_values(&:to_s)

  def root_camp_unit
    ROOT_CAMP_UNITS[stufe&.to_sym]
  end
end
