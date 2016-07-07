module BookmarksHelper
	def find_list_by_id(id)
		TodoList.find(id)
	end

	def find_user_by_id(id)
		User.find(id)
	end
end
