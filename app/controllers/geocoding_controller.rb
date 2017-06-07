require 'open-uri'

class GeocodingController < ApplicationController
  def street_to_coords_form
    # Nothing to do here.
    render("geocoding/street_to_coords_form.html.erb")
  end

  def street_to_coords
    @street_address = params[:user_street_address]

    # ==========================================================================
    # Your code goes below.
    #
    # The street address that the user typed is in the variable @street_address.
    # ==========================================================================

@street_address_pluses = @street_address.gsub(" ","+")
url = "https://maps.googleapis.com/maps/api/place/textsearch/json?query=restaurants+near+"+@street_address_pluses+"&key=AIzaSyBeUgmjuyv4-L8rthcBDEiA8T7H9HD6OLc"
parsed_data = JSON.parse(open(url).read)

parsed_data["results"].each do |name, place_id|
    # @latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]
    #
    # @longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]


    @name = name

    @place_id = place_id

    # @address = formatted_address

  end

    render("geocoding/street_to_coords.html.erb")
  end
end
