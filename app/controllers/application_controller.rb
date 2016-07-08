class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  	def permit_crud_for_current_user?(todo_list)
		allow = current_user.id == todo_list.user_id
		redirect_to todo_list, notice: "you don't edit this item" if !allow
	end
end
