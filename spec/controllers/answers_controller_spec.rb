require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { create(:question) }

  describe "POST #create" do
    context 'with valid attributes' do
      let(:new_answer) { post :create, params: { answer: attributes_for(:answer), question_id: question } }

      it 'save a new answer in the database' do
        expect{new_answer }.to change(Answer, :count).by(1)
      end

      it 'redirect to show view' do
        new_answer
        expect(response).to redirect_to assigns(:answer)
      end
    end

    context 'with invalid attributes' do
      let(:new_answer) { post :create, params: { answer: attributes_for(:answer, :invalid), question_id: question } }

      it 'does not save a new answer in the database' do
        expect{new_answer }.to_not change(Answer, :count)
      end

      it 're-render to new view' do
        new_answer
        expect(response).to render_template :new
      end
    end
  end
end
