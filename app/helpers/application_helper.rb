module ApplicationHelper
	def show_link_actions?
	  current_user.id == @todo_list.user_id		
	end
end
