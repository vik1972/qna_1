require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:question) { create(:question) }

  describe "GET #index" do
    let(:questions){ create_list(:question, 3) }
    before  {get :index}

    it 'fills in the array of all questions' do
      expect(assigns(:questions)).to match_array(questions)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe "GET #show" do
    before {get :show, params: { id: question } }

    it 'assigns the requested question to @question' do
      expect(assigns(:question)).to eq question
    end

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    before {get :new }

    it 'assigns the new Question to @question' do
      expect(assigns(:question)).to be_a_new(Question)
    end

    it 'renders new vie' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      let(:question) { post :create, params: { question: attributes_for(:question) } }

      it 'save a new question in the database' do
        expect{ question }.to change(Question, :count).by(1)
      end

      it 'redirect to show view' do
        question
        expect(response).to redirect_to assigns(:question)
      end
    end

    context 'with invalid attributes' do
      let(:question) { post :create, params: { question: attributes_for(:question, :invalid) } }

      it 'does not save a new question in the database' do
        expect{ question }.to_not change(Question, :count)
      end

      it 're-renders to new view' do
        question
        expect(response).to render_template :new
      end
    end
  end

end
