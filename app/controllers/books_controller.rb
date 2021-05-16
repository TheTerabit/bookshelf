class BooksController < ApplicationController
  # first line inside the class:
  before_action :login_required, except: [:index, :show]
  # notice we've defined a method called index for a BooksController instance. We tie this together with routes
  def index
    @books = Book.paginate page: params[:page], per_page: 10 # instance variables are prefixed with an @.
    # If we said books = Book.all, we wouldn't be able to access books in the template
  end
  def show
    @book = Book.find(params[:id])
    @comments = @book.comments.paginate(page: params[:page], per_page: 10).order('created_at ASC')
  end
  def new
    @book = Book.new
  end

  def create
    @book = Book.new book_params
    if @book.save
      flash[:notice] = "#{@book.title} saved."
      redirect_to @book
    else
      render :new
    end
  end

  def update
    @book = Book.find params[:id]
    if @book.update_attributes(book_params)
      flash[:notice] = "#{@book.title} saved."
      redirect_to @book
    else
      render :edit
    end
  end

  def destroy
    book = Book.find params[:id]
    book.destroy
    flash[:notice] = "#{book.title} deleted."
    redirect_to books_path
  end

  # after all the actions
  def login_required
    unless current_admin
      flash[:error] = 'Only logged in admins an access this page.'
      redirect_to books_path
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :thoughts)
  end
  def edit
    @book = Book.find params[:id]
  end
end