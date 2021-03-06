class BookmarksController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_bookmark, only: [:show, :edit, :update, :destroy]

  def index
    @bookmarks = Bookmark.where(user_id: current_user.id)
  end


  def show
  end

  def new
    @bookmark = Bookmark.new
    users = User.where.not(id: current_user.id)
    @todo_list = TodoList.where(user_id: users).where(private_list: false)   
  end


  def edit
  end


  def create
    @bookmark = Bookmark.new(bookmark_params)
    @bookmark.user_id = current_user.id

    respond_to do |format|
      if @bookmark.save
        format.html { redirect_to bookmarks_url, notice: 'Bookmark was successfully created.' }
        format.json { render :show, status: :created, location: @bookmark }
      else
        format.html { render :new }
        format.json { render json: @bookmark.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    respond_to do |format|
      if @bookmark.update(bookmark_params)
        format.html { redirect_to @bookmark, notice: 'Bookmark was successfully updated.' }
        format.json { render :show, status: :ok, location: @bookmark }
      else
        format.html { render :edit }
        format.json { render json: @bookmark.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @bookmark.destroy
    respond_to do |format|
      format.html { redirect_to bookmarks_url, notice: 'Bookmark was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  
    def set_bookmark
      @bookmark = Bookmark.find(params[:id])
    end

   
    def bookmark_params
      params.require(:bookmark).permit(:todo_list_id, :user_id)
    end
end
