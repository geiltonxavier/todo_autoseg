class TodoItemsController < ApplicationController
	before_filter :authenticate_user!
	before_action :set_todo_list	
	before_action :set_todo_item, except: [:create]
	before_action except: [:index] do
		permit_crud_for_current_user?(@todo_list)
	end

	def create 
		@todo_item = @todo_list.todo_items.create(todo_item_params)
		redirect_to @todo_list
	end

	def destroy	   
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

    def complete        
	       	@todo_item.update_attributes(completed_at: Time.now)
	    	respond_to do |format|
	    	format.html { redirect_to @todo_list, notice: 'Todo item completed.' }
       end    	
    end

	private


	# def permit_crud_for_current_user?
	# 	allow = current_user.id == @todo_list.user_id
	# 	redirect_to @todo_list, notice: "you don't edit this item" if !allow
	# end

	def set_todo_list
		@todo_list = TodoList.find(params[:todo_list_id])		
	end

	def set_todo_item
		@todo_item = @todo_list.todo_items.find([params[:id]]).first
	end

	def todo_item_params
		params[:todo_item].permit(:content)
	end
end
