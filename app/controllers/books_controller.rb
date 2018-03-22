class BooksController < ApplicationController

  before_action :require_user, except: [:show, :index]
  before_action :set_book, only: [:show, :require_permission]
  before_action :require_permission, only: [:edit, :update, :destroy]



  # GET /books
  # GET /books.json
  def index
    #@books = Book.all
    if params[:keyword]
      cookies[:keyword] = {value: params[:keyword], expires: 3.minutes.from.now}
      @books = Book.where('title like ?', "%#{params[:keyword]}%").paginate(:page => params[:page], :per_page => 10)
    else
      @books = Book.paginate(:page => params[:page], :per_page => 5)
    end
  end

  # GET /books/1
  # GET /books/1.json
  def show
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id

    respond_to do |format|
      if @book.save
        flash[:success] = 'Book was successfully created.'
        format.html { redirect_to @book } #success: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        flash[:success] = 'Book was successfully updated.'
        format.html { redirect_to @book }#, notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      flash[:success] = 'Book was successfully destroyed.'
      format.html { redirect_to books_url }#, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:title, :author, :description, :keyword)
    end

    # Users can only edit books which belong to them
    def require_permission
      owner = User.find(set_book.user_id)
      if current_user != owner && current_user.admin == false
        flash[:danger] = "You can't access to other's books"
        redirect_to books_url
      end
    end
end
