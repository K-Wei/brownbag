class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all
    @location_hash = Gmaps4rails.build_markers(@restaurants.where.not(:location_latitude => nil)) do |restaurant, marker|
      marker.lat restaurant.location_latitude
      marker.lng restaurant.location_longitude
      marker.infowindow "<h5><a href='/restaurants/#{restaurant.id}'>#{restaurant.name}</a></h5><small>#{restaurant.location_formatted_address}</small>"
    end

    render("restaurants/index.html.erb")
  end

  def show
    @event = Event.new
    @restaurant = Restaurant.find(params[:id])

    render("restaurants/show.html.erb")
  end

  def new
    @restaurant = Restaurant.new

    render("restaurants/new.html.erb")
  end

  def create
    @restaurant = Restaurant.new

    @restaurant.name = params[:name]
    @restaurant.location = params[:location]
    @restaurant.yelp_url = params[:yelp_url]
    @restaurant.price = params[:price]
    @restaurant.categories = params[:categories]
    @restaurant.picture_url = params[:picture_url]

    save_status = @restaurant.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/restaurants/new", "/create_restaurant"
        redirect_to("/restaurants")
      else
        redirect_back(:fallback_location => "/", :notice => "Restaurant created successfully.")
      end
    else
      render("restaurants/new.html.erb")
    end
  end

  def edit
    @restaurant = Restaurant.find(params[:id])

    render("restaurants/edit.html.erb")
  end

  def update
    @restaurant = Restaurant.find(params[:id])

    @restaurant.name = params[:name]
    @restaurant.location = params[:location]
    @restaurant.yelp_url = params[:yelp_url]
    @restaurant.price = params[:price]
    @restaurant.categories = params[:categories]
    @restaurant.picture_url = params[:picture_url]

    save_status = @restaurant.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/restaurants/#{@restaurant.id}/edit", "/update_restaurant"
        redirect_to("/restaurants/#{@restaurant.id}", :notice => "Restaurant updated successfully.")
      else
        redirect_back(:fallback_location => "/", :notice => "Restaurant updated successfully.")
      end
    else
      render("restaurants/edit.html.erb")
    end
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])

    @restaurant.destroy

    if URI(request.referer).path == "/restaurants/#{@restaurant.id}"
      redirect_to("/", :notice => "Restaurant deleted.")
    else
      redirect_back(:fallback_location => "/", :notice => "Restaurant deleted.")
    end
  end
end
