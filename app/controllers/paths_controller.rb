class PathsController < ApplicationController

	def create
		@path = Path.new(params.require(:path).permit(:to_user_id))
		@path.question = params[:quesition_id]
		@path.from_user_id = current_user.id
		if @path.save
			redirect_to question_path(params[:question_id])
		else
			render 'error'
		end

		if not User.find(params[:to_user_id])  
			redirect_to question_path(params[:question_id]), :flash => {:flag => "1"}
		end
	end

end
