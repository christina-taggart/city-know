class AnswersController < ApplicationController
  def index
    @question = Question.find(params[:question_id])
    @answers = @question.answers
  end

  def show
    @answer = Answer.find(params[:answer_id])
  end

  def new
    @city = City.find(params[:city_id])
    @question = Question.find(params[:question_id])
    @answer = Answer.new
  end

  def create
    @city = City.find(params[:city_id])
    @question = Question.find(params[:question_id])
    @answer = Answer.new(params[:answer])
    if @answer.save
      redirect_to city_question_path(@city, @question)
    else
      @errors = @city.errors.full_messages
      render :new
    end
  end

  def edit
    @city = City.find(params[:city_id])
    @question = Question.find(params[:question_id])
    @answer = Answer.find(params[:question_id])
  end

  def update
    @city = City.find(params[:city_id])
    @question = Question.find(params[:question_id])
    @answer = Answer.find(params[:answer_id])
    if @answer.update_attributes(params[:answer])
      redirect_to city_question_path(@city, @question)
    else
      redirect_to edit_city_question_answer_path(@city, @question, @answer)
    end
  end

  def destroy
    @city = City.find(params[:city_id])
    @question = Question.find(params[:question_id])
    @answer = Answer.find(params[:answer_id])
    @answer.destroy
    redirect_to city_question_path(@city, @question)
  end
end
