class EventsController < ApplicationController
  include GoogleCalendarizable
  
  before_action :authenticate
  
  def index
    service = calendar_service
    @calendar = service.get_calendar(params[:calendar_id])
    @events = service.list_events(  
      @calendar.id,
      max_results: 10,
      single_events: true,
      order_by: "startTime",
      time_min: DateTime.now.rfc3339
    ).items
    #binding.pry
  end
end