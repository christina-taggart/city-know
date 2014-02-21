class QuestionsController < ApplicationController

	def index
		@city = City.find(params[:city_id])
		@questions = @city.questions
	end

	def new
		@question = Question.new
		@city = City.find(params[:city_id])
	end

	def create
		question = Question.new(params[:question])
		if question.save
			redirect_to city_question_path(question)
		else
			erb :new
		end
	end

	def show
	end

	def edit
	end


	def update
		question = Question.find(params[:id])
		if question.update_attributes(params[:question])
			redirect_to city_post_path
		else
			erb :edit
		end
	end

	def destroy
	end
end