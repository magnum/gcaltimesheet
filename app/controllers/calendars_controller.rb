require 'google/api_client/client_secrets.rb'
require 'google/apis/calendar_v3'

class CalendarsController < ApplicationController
  include GoogleCalendarizable

  before_action :authenticate
  def index
    service = calendar_service
    @calendars = service.list_calendar_lists.items
    #binding.pry
  end
end