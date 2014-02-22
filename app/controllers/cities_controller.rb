class CitiesController < ApplicationController
  def index
    @cities = City.all
  end

  def show
    @city = City.find(params[:id])
    @questions = @city.questions
  end

  def new
    authenticate_user!
    @city = City.new
  end

  def create
    authenticate_user!
    @city = City.new(params[:city])
    if @city.save
      redirect_to city_path(@city)
    else
      flash.now[:errors] = @city.errors.full_messages
      render action: 'new'
    end
  end

  def edit
    authenticate_user!
    @city = City.find(params[:id])
  end

  def update
    authenticate_user!
    @city = City.find(params[:id])
    if @city.update_attributes(params[:city])
      redirect_to city_path(@city)
    else
      flash.now[:errors] = @city.errors.full_messages
      render action: 'edit'
    end
  end

  def destroy
    @city = City.find(params[:id])
    @city.destroy
    redirect_to root_path
  end
end
