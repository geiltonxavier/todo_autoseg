class AddPrivateListToTodoLists < ActiveRecord::Migration[5.0]
  def change
    add_column :todo_lists, :private_list, :boolean
  end
end
