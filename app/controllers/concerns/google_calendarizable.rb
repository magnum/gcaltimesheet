require 'google/api_client/client_secrets.rb'
require 'google/apis/calendar_v3'

module GoogleCalendarizable
  extend ActiveSupport::Concern

  def calendar_service
    token = current_user.google_token
    # Initialize Google Calendar API
    service = Google::Apis::CalendarV3::CalendarService.new
    # Use google keys to authorize
    service.authorization = token.google_secret.to_authorization
    # Request for a new access token just incase it expired
    if token.expired?
      new_access_token = service.authorization.refresh!
      token.access_token = new_access_token['access_token']
      token.expires_at = 
        Time.now.to_i + new_access_token['expires_in'].to_i
      token.save
    end
    service
  end

end
