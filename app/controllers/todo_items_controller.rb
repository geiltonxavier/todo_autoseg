class TodoItemsController < ApplicationController

	before_action :set_todo_list

	def create 
		@todo_item = @todo_list.todo_items.create(todo_item_params)
		redirect_to @todo_list
	end


	def destroy
	    @todo_item = @todo_list.todo_items.find(params[:id])
		respond_to do |format|
	      if @todo_item.destroy	      	
	        format.html { redirect_to @todo_list, notice: 'Todo item was successfully destroyed.' }
	        format.json { render :show, status: :destroyed, location: @todo_list }
	      else
	        format.html { render :edit }
	        format.json { render json: @todo_list.errors, status: :unprocessable_entity }
	      end
	    end
    end

	private

	def set_todo_list
		@todo_list = TodoList.find(params[:todo_list_id])		
	end

	def todo_item_params
		params[:todo_item].permit(:content)
	end
end
