class PathsController < ApplicationController

def create
	@path = Path.new(params.require(:path).permit(:question, :to_user))
	@path.from_user = current_user.id
	if @path.save
		redirect_to question_path
	else
		render 'error'
	end
end

end