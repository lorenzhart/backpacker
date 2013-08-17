class PathsController < ApplicationController

	def create
		@path = Path.new(params.require(:path).permit(:to_user_id))
		@path.question = params[:quesition_id]
		@path.from_user_id = current_user.id
		if not @path.save
			render 'error'
		end

		if not User.find_by_id(params[:to_user_id])  
			redirect_to question_path(params[:question_id]), :flash => {:flag => "1", :dialog_request_id => params[:path][:to_user_id], :test => @graph}
		end

#@graph = Koala::Facebook::API.new(current_user.omnitoken)
#@graph.put_object("me", "apprequests", {:appid => MY_APP_ID, :to => USER_ID,  :message => "Come join me!"} )


#def facebook_friends
#  access_token = self.token
#  @graph = Koala::Facebook::API.new(access_token)
#  friends = @graph.get_connections("me", "friends")
#  return friends
#end


	end

end
