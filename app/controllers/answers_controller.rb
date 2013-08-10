class AnswersController < ApplicationController
	def create
		@question = Question.find(params[:question_id])
		@answer = @question.answers.build(params.require(:answer).permit(:answer))
		@answer.user_id = current_user.id

		if @answer.save
			redirect_to question_path(@question)
		else
			render action: 'new'
		end
	end

end
