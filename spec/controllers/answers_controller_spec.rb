require 'spec_helper'
describe AnswersController do
  before do
    AnswersController.any_instance.stub(:current_user).and_return(user)
    AnswersController.any_instance.stub(:authenticate_user!).and_return(true)
  end
  let!(:city) { FactoryGirl.create :city }
  let!(:question) { FactoryGirl.create :question }
  let!(:answer) { FactoryGirl.create :answer }
  let!(:user) { FactoryGirl.create :user }
  context 'answers#index' do
    before(:each) do
      get :index, city_id: city.id, question_id: question.id
    end
    it "is successful" do
      expect(response).to be_success
    end

    it "assigns all answers to @answers" do
      expect(assigns(:answers)).to eq question.answers
    end
  end

  context '#show' do
    it "displays current answer" do
      get :show, city_id: city.id, question_id: question.id, id: answer.id
      expect(assigns(:answer)).to eq answer
    end
  end

  context '#new' do
    it "makes a new answer" do
      get :new, city_id: city.id, question_id: question.id
      expect(assigns(:answer)).to be_a_new Answer
    end
  end

  context '#create' do
    it "creates a new answer" do
      post :create, city_id: city.id, question_id: question.id, answer:FactoryGirl.attributes_for(:answer)
      expect(response).to be_redirect
    end

    it "renders new view" do
      post :create, city_id: city.id, question_id: question.id
      expect{answer = Answer.create()}.to render_template 'new'
    end
  end

  context '#edit' do
    it "assigns answers to @answer" do
      get :show, city_id: city.id, question_id: question.id, id: answer.id
      expect(assigns(:answer)).to eq answer
    end
  end

  context '#update' do
    it "updates the current answer attributes" do
      expect {
        put :update, city_id: city.id, question_id: question.id, id: answer.id, answer: {body: "new answer"}
      }.to change { answer.reload.body }.to("new answer")
      expect(response).to be_redirect
    end
  end

  context '#destroy' do
    it "deletes the current answer" do
      expect {
        delete :destroy, city_id: city.id, question_id: question.id, id: answer.id
      }.to change { Answer.count }.by(-1)
      expect(response).to be_redirect
    end
  end

end