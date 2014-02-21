require 'spec_helper'

describe CitiesController do
  let!(:city) { FactoryGirl.create :city }
  context '#index' do
    before(:each) do
      get :index
    end
    it "is successful" do
      expect(response).to be_success
    end

    it "assigns all cities to @cities" do
      expect(assigns(:cities)).to eq City.all
    end
  end

  context '#show' do
    it "displays current city" do
      get :show, id: city.id
      expect(assigns(:city)).to eq city
    end
  end

  context '#new' do
    it "makes a new city" do
      get :new
      expect(assigns(:city)).to be_a_new City
    end
  end

  context '#create' do
    it "creates a new city" do
      get :create
      expect(response).to render_template :index
    end

    it "flashes an error" do
      pending
    end

    it "renders new view" do
      pending
    end
  end

end