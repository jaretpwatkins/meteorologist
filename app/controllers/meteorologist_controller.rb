require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("meteorologist/street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]

    # ==========================================================================
    # Your code goes below.
    #
    # The street address that the user typed is in the variable @street_address.
    # ==========================================================================
    @street_address_pluses = @street_address.gsub(" ","+")
    url = "http://maps.googleapis.com/maps/api/geocode/json?address="+@street_address_pluses
    parsed_data = JSON.parse(open(url).read)


        @latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]

        @longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]

        url = "https://api.darksky.net/forecast/a167b70febd3a3a5eb81bf836a9a91af/"+@latitude.to_s+","+@longitude.to_s
        parsed_data = JSON.parse(open(url).read)

    @current_temperature = parsed_data["currently"]["temperature"]

    @current_summary = parsed_data["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_data["minutely"]["summary"]

    @summary_of_next_several_hours = parsed_data["hourly"]["summary"]

    @summary_of_next_several_days = parsed_data["daily"]["summary"]

    render("meteorologist/street_to_weather.html.erb")
  end
end
