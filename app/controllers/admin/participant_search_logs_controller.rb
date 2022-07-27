# frozen_string_literal: true

module Admin
  class ParticipantSearchLogsController < ApplicationController
    def show
      includes = [:searcher]
      @logs = ParticipantSearchLog.all.order(created_at: :desc).includes(includes)
    end
  end
end
