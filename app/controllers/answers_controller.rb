class AnswersController < ApplicationController
	def create
		@question = Question.find(params[:question_id])
		@answer = Question.find(params[:question_id]).answers.create(params.require(:answer).permit(:answer))
		redirect_to question_path(@question)
	end
end
