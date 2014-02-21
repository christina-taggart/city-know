class CitiesController < ApplicationController
  def index
    @cities = City.all
  end

  def show
    @city = City.find(params[:id])
  end

  def new
    @city = City.new
  end

  def create
    @city = City.new(params[:city])
    if @city.save
      redirect_to city_path(@city)
    else
      @errors = @city.errors.full_messages
      render :new
    end
  end

  def edit
    @city = City.find(params[:id])
  end

  def update
    @city = City.find(params[:id])
    if @city.update_attributes(params[:city])
      redirect_to city_path(@city)
    else
      redirect_to edit_city_path(@city)
    end
  end

  def destroy
    @city = City.find(params[:city_id])
    @city.destroy
    redirect_to root_path
  end
end
