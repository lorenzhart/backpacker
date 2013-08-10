class QuestionsController < ApplicationController

	def index
		@questions = Question.all
	end

	def show
		@question = Question.find(params[:id])
		@answer = Question.find(params[:id]).answers.build
	end

	def create
		@question = Question.new(params.require(:question).permit(:title, :content, :resolved))
		@question.user_id = current_user.id
		if @question.save
			redirect_to questions_path
		else
			render action: 'new'
		end
	end

	def new
		@question = Question.new

	end


	def destroy

	end


end
