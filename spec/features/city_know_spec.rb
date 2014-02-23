require 'spec_helper'

describe "City Know", js: true do
  let!(:city) { FactoryGirl.create :city }
  context "Visitor can navigate the welcome screen" do
    it "by visiting the homepage" do
      visit root_path
      expect(page).to  have_content "Welcome to City Know!"
    end
    it "and can sign up for the site" do
      visit root_path
      click_link('Sign Up')
      fill_in('Email', with: "John@example.com")
      fill_in('Password', with: "password123")
      fill_in('Password confirmation', with: "password123")
      expect(page).to have_content :city
    end
    it "and can sign into the site" do
      visit root_path
      click_link('Log in')
      fill_in('Email', with: "spencer@example.com")
      fill_in('Password', with: "spencer1")
      expect(page).to have_content :city
    end
  end

  # context "User can navigate the logged-in state" do
  #   before do
  #     ApplicationController.any_instance.stub(:current_user).and_return(user)
  #     ApplicationController.any_instance.stub(:authenticate_user!).and_return(true)
  #   end
  #   let!(:user) { FactoryGirl.create :user }
  #   it "and can see a list of cities" do
  #     visit cities_path
  #     expect(page).to  have_content "San Francisco"
  #   end
  #   it "and can select a city" do
  #     visit cities_path
  #     click_link('San Francisco')
  #     expect(page).to have_content "Post a new question"
  #   end
  # end
end