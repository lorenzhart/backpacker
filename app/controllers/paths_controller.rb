class PathsController < ApplicationController

	def create
		@path = Path.new(params.require(:path).permit(:to_user_id))
		@path.question_id = params[:question_id]
		@path.from_user_id = current_user.id
		if not @path.save
			render 'error'
		end

		if not User.find_by(uid: params[:path][:to_user_id])  
			redirect_to question_path(params[:question_id]), :flash => {:flag => "1", :dialog_request_id => params[:path][:to_user_id]}
		end
			redirect_to question_path(params[:question_id])
	end

	

end
