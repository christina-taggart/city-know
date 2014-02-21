class QuestionsController < ApplicationController

	respond_to :html, :xml, :json

	def index
		@city = City.find(params[:city_id])
		@questions = @city.questions
	end

	def new
		@city = City.find(params[:city_id])
		@question = @city.questions.build
		respond_with(@city, @question)
	end

	def create
		@city = City.find(params[:city_id])
		@question = @city.questions.build(params[:question])
		@question.save
		respond_with(@city, @question)
	end

	def show
		@question = Question.find(params[:id])
	end

	def edit
		@question = Question.find(params[:id])
		@city = City.find(params[:city_id])
	end


	def update
		question = Question.find(params[:id])
		city = City.find(params[:city_id])
		if question.update_attributes(params[:question])
			redirect_to city_question_path(question, city)
		else
			erb :edit
		end
	end

	def destroy
	end
end