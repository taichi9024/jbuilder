class BooksController < ApplicationController
  protect_from_forgery except: [:destroy]
  before_action :set_book
  around_action :delete_logger, only:[:destroy]
  before_action :variant_t, only:[:show]

  def show
    @book = Book.find(params[:id])
    respond_to do |format|
      format.html
      format.json 
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    respond_to do |format|
      format.html {redirect_to "/"}
      format.json {head :no_content}
    end
  end

  private
  def set_book
    @book = Book.find_by(id:params[:id])
  end

  def delete_logger
    puts "pre-delete"
    yield
    puts "after-delete"
  end

  def variant_t
    request.variant = :mobile if request.user_agent =~ /iphone/
  end
end
