class QuestionsController < ApplicationController
  def index
  	@questions = Question.all
  end

  def show
  	@questions = Question.find(params[:id])
  end

  def new
  	@questions = Question.new
  end

  def create
    @questions = Question.new
    @questions.title = params[:question][:title]
    @questions.body = params[:question][:body]

    if @questions.save
      flash[:notice] = "Question was saved."
      redirect_to @questions
    else
      flash[:error] = "There was an error saving the question. Please try again."
      render :new
    end
   end
end
