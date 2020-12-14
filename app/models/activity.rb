# frozen_string_literal: true

class Activity < ApplicationRecord
  include Bitfields
  extend Mobility

  has_many_attached :activity_documents
  has_one_attached :picture
  has_and_belongs_to_many :tags, optional: true
  belongs_to :transport_location, optional: true
  belongs_to :activity_category, optional: true
  has_and_belongs_to_many :goals
  has_and_belongs_to_many :stufen
  has_and_belongs_to_many :stufe_recommended, class_name: 'Stufe', join_table: 'activities_stufen_recommended'

  bitfield :language_flags, :language_de, :language_fr, :language_it, :language_en
  enum block_type: { la: 'la', ls: 'ls' }
  enum simo: { berg: 'berg', wasser: 'wasser', pool: 'pool', lake: 'lake' }
  enum activity_type: { excursion: 'excursion', activity: 'activity',
                        village_global: 'village_global', frohnarbeit: 'frohnarbeit' }

  validates :block_type, :participants_count_activity, :stufen,
            :stufe_recommended, :activity_category, presence: true
  validates :duration_activity, format: { with: /\A\d{2}:\d{2}\z/ }, allow_nil: true

  translates :label, type: :string, locale_accessors: true, fallbacks: true
  translates :description, type: :text, locale_accessors: true, fallbacks: true

  def languages
    bitfield_values(:language_flags)
  end
end
