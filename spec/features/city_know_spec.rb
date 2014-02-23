require 'spec_helper'

describe "City Know", js: true do
  let!(:user) { FactoryGirl.create :user }
  let!(:city) { City.create!(name: 'San Francisco', description: "The City by the Bay") }
  let!(:question) { Question.create!(title: "Who are you?", body: "The Faunz") }
  let!(:answer) { FactoryGirl.create :answer }
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

  context "User can navigate the logged-in state to create content" do
    before(:each) do
      ApplicationController.any_instance.stub(:current_user).and_return(user)
      ApplicationController.any_instance.stub(:authenticate_user!).and_return(true)
    end
    it "and can see a list of cities" do
      visit cities_path
      expect(page).to  have_content :city
    end
    it "and can select a city" do
      visit cities_path
      click_link('San Francisco')
      expect(page).to have_content "Post a new question"
    end
    it "and can render question template page" do
      visit '/cities/1'
      click_link('Post a new question')
      expect(page).to have_content "Title"
    end
    it "and can post a question" do
      visit '/cities/1/questions/new'
      fill_in('Title', with: "What are the best things?")
      fill_in('Body', with: "I want to know the best things.")
      click_button('Submit')
      expect(page).to have_content :question
    end
    it "and can write an answer" do
      visit '/cities/1/questions/1'
      fill_in("answer[body]", with: "I am the best thing")
      click_button('Submit')
      expect(page).to have_content :answer
    end
  end

  # context "User can navigate the logged-in state to edit/delete content" do
  #   before(:each) do
  #     ApplicationController.any_instance.stub(:current_user).and_return(user)
  #     ApplicationController.any_instance.stub(:authenticate_user!).and_return(true)
  #   end
  #   it "and can see the question edit template" do
  #     visit '/cities/1/questions/1'
  #     click_link('Edit Question')
  #     expect(page).to have_content "Title"
  #   end
  # end
end