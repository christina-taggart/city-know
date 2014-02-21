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
      post :create, city: FactoryGirl.attributes_for(:city)
      expect(response).to be_redirect
    end

    it "renders new view" do
      post :create
      expect{city = City.create()}.to render_template 'new'
    end
  end

  context '#edit' do
    it "assigns city to @city" do
      get :show, id: city.id
      expect(assigns(:city)).to eq city
    end
  end

  context '#update' do
    it "updates the current city attributes" do
      expect {
        put :update, id: city.id, city: {name: "SF"}
      }.to change { city.reload.name }.to("SF")
      expect(response).to be_redirect
    end
  end

  context '#destroy' do
    it "deletes the current city" do
      expect {
        delete :destroy, id: city.id
      }.to change { City.count }.by(-1)
      expect(response).to be_redirect
    end
  end

end