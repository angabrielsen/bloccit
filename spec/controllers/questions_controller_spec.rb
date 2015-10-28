require 'rails_helper'
include RandomData

RSpec.describe QuestionsController, type: :controller do
  let (:my_q) do
    Question.create(
      id: 1,
      title: RandomData.random_sentence,
      body: RandomData.random_paragraph,
      resolved: false
      )
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "assigns [my_q] to @questions" do
      get :index
      expect(assigns(:questions)).to eq([my_q])
    end
  end

  describe "GET show" do
     it "returns http success" do
 
       get :show, {id: my_q.id}
       expect(response).to have_http_status(:success)
     end

     it "renders the #show view" do
 
       get :show, {id: my_q.id}
       expect(response).to render_template :show
     end
 
     it "assigns my_q to @questions" do
       get :show, {id: my_q.id}
 
       expect(assigns(:questions)).to eq(my_q)
     end
   end

  describe "GET new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "renders the #new view" do
        get :new
        expect(response).to render_template :new
      end

      it "instantiates @questions" do
        get :new
        expect(assigns(:questions)).not_to be_nil
      end
    end

  describe "POST create" do
     it "increases the number of Questions by 1" do
       expect{ post :create, {questions: {title: "Title", body: "Body", resolved: false}} }.to change(Question,:count).by(1)
     end

     it "assigns the new question to @question" do
       post :create, {questions: my_q.attributes}
       expect(assigns(:questions)).to eq Question.last
     end

     it "redirects to the new question" do
       post :create, {questions: my_q.attributes}
       expect(response).to redirect_to Question.last
     end
   end
end
