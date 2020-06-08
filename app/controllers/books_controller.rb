class BooksController < ApplicationController
  before_action :authenticate_user!

  def show
  	@book = Book.find(params[:id])
    @newbook = Book.new
    @user = @book.user
    @book_comment = BookComment.new
  end

  def index
  	@books = Book.all #一覧表示するためにBookモデルの情報を全てくださいのall
    @newbook = Book.new
    @user = current_user
  end

  def create
  	@newbook = Book.new(book_params)
     #Bookモデルのテーブルを使用しているのでbookコントローラで保存する。
    @newbook.user_id = current_user.id
  	if @newbook.save #入力されたデータをdbに保存する。
  		redirect_to book_path(@newbook), notice: "successfully created book!"#保存された場合の移動先を指定。
  	else
  		@books = Book.all
      @user = current_user
  		render "index"
  	end
  end

  def edit
  	@book = Book.find(params[:id])
    if @book.user.id != current_user.id
    redirect_to books_path
    end
  end



  def update
  	@book = Book.find(params[:id])
  	if @book.update(book_params)
  		redirect_to book_path(@book), notice: "successfully updated book!"
  	else #if文でエラー発生時と正常時のリンク先を枝分かれにしている。
  		render "edit"
  	end
  end

  def destroy
  	book = Book.find(params[:id])
  	book.destroy
  	redirect_to books_path, notice: "successfully delete book!"
  end

  private

  def book_params
  	params.require(:book).permit(:title, :body, :book_id)
  end

end
