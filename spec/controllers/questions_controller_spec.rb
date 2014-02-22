require 'spec_helper'

describe QuestionsController do
  before do
    QuestionsController.any_instance.stub(:authenticate_user!).and_return(true)
  end
  let!(:city) { FactoryGirl.create :city }
  let!(:question) { FactoryGirl.create :question }
  context 'questions#index' do
    before(:each) do
      get :index, city_id: city.id
    end
    it "is successful" do
      expect(response).to be_success
    end

    it "assigns all questions to @questions" do
      expect(assigns(:questions)).to eq city.questions
    end
  end

  context '#show' do
    it "displays current question" do
      get :show, city_id: city.id, id: question.id
      expect(assigns(:question)).to eq question
    end
  end

  context '#new' do
    it "makes a new question" do
      get :new, city_id: city.id
      expect(assigns(:question)).to be_a_new Question
    end
  end

  context '#create' do
    it "creates a new question" do
      post :create, city_id: city.id, question: FactoryGirl.attributes_for(:question)
      expect(response).to be_redirect
    end

    it "renders new view" do
      post :create, city_id: city.id
      expect{question = Question.create()}.to render_template 'new'
    end
  end

  context '#edit' do
    it "assigns questions to @question" do
      get :show, city_id: city.id, id: question.id
      expect(assigns(:question)).to eq question
    end
  end

  context '#update' do
    it "updates the current question attributes" do
      expect {
        put :update, city_id: city.id, id: question.id, question: {body: "new question"}
      }.to change { question.reload.body }.to("new question")
      expect(response).to be_redirect
    end
  end

  context '#destroy' do
    it "deletes the current question" do
      expect {
        delete :destroy, city_id: city.id, id: question.id
      }.to change { Question.count }.by(-1)
      expect(response).to be_redirect
    end
  end

end