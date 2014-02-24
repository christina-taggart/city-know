class QuestionsController < ApplicationController

	respond_to :html, :xml, :json

	def index
		@city = City.find(params[:city_id])
		@questions = @city.questions
	end

	def new
		authenticate_user!
		@city = City.find(params[:city_id])
		@question = @city.questions.build
		respond_with(@city, @question)
	end

	def create
		authenticate_user!
		@user = current_user
		@city = City.find(params[:city_id])
		@question = @city.questions.build(params[:question])
		if @question.save
			@user.questions << @question
			redirect_to city_question_path(@city, @question)
		else
			flash.now[:errors] = @question.errors.full_messages
			render :new
		end
	end

	def show
		@city = City.find(params[:city_id])
		@question = Question.find(params[:id])
		@subscription = Subscription.where(question_id: @question.id, user_id: current_user.id)
		@answer = Answer.new
	end

	def edit
		authenticate_user!
		@question = Question.find(params[:id])
		@city = City.find(params[:city_id])
	end


	def update
		authenticate_user!
		question = Question.find(params[:id])
		city = City.find(params[:city_id])
		if question.update_attributes(params[:question])
			redirect_to city_question_path(city, question)
		else
			flash.now[:errors] = @question.errors.full_messages
			erb :edit
		end
	end

	def destroy
		authenticate_user!
		Question.find(params[:id]).destroy
		redirect_to city_path(params[:city_id])
	end
end