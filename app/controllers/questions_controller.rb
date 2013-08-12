class QuestionsController < ApplicationController

	def index
		@questions = Question.all
		@received_questions = current_user.try(:received_questions)||[]
		@question = Question.new
	end

	def show
		@question = Question.find(params[:id])
		@answer = Question.find(params[:id]).answers.build
		@friends = current_user.try(:facebook_friends)
		@path = Path.new
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
