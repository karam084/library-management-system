class BooksController < ApplicationController
  #before_action authenticate
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  	
  # def authenticate
    # if current_admin.nil? 
        # :authenticate_admin!
	# elsif current_librarian.nil?
		# :authenticate_librarian!
	# elsif current_student.nil?
		# :authenticate_student!
    # end
  # end
  
  # GET /books
  # GET /books.json
  def index
    @books = Book.all
  end
  
  def books_students	
	@books = Book.all.where(:library_id => Library.select('id').where(:university => Student.select('university').where(:email => current_student.email)))
	@books_all = Book.all
  end

  # GET /books/1
  # GET /books/1.json
  def show
  end

  # GET /books/new
  def new
	if student_signed_in?
      redirect_to students_path, notice: 'Action not allowed.'
	else
		@book = Book.new
	end
  end

  # GET /books/1/edit
  def edit
	if student_signed_in?
      redirect_to students_path, notice: 'Action not allowed.'
	end
  end

  # POST /books
  # POST /books.json
  def create
	if student_signed_in?
      redirect_to students_path, notice: 'Action not allowed.'
	else
		@book = Book.new(book_params)

		respond_to do |format|
		  if @book.save
			format.html { redirect_to @book, notice: 'Book was successfully created.' }
			format.json { render :show, status: :created, location: @book }
		  else
			format.html { render :new }
			format.json { render json: @book.errors, status: :unprocessable_entity }
		  end
		end
	end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    if student_signed_in?
      redirect_to students_path, notice: 'Action not allowed.'
	else
		respond_to do |format|
		  if @book.update(book_params)
			format.html { redirect_to @book, notice: 'Book was successfully updated.' }
			format.json { render :show, status: :ok, location: @book }
		  else
			format.html { render :edit }
			format.json { render json: @book.errors, status: :unprocessable_entity }
		  end
		end
	end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
	if student_signed_in?
      redirect_to students_path, notice: 'Action not allowed.'
	else
		@book.destroy
		
		if current_admin.nil? and current_librarian.nil?
			respond_to do |format|
			  format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
			  format.json { head :no_content }
			end
		elsif !current_admin.nil?
			respond_to do |format|
			  format.html { redirect_to show_books_path, notice: 'Book was successfully destroyed.' }
			  format.json { head :no_content }
			end		
		elsif !current_librarian.nil?
			respond_to do |format|
			  format.html { redirect_to librarian_book_view_path, notice: 'Book was successfully destroyed.' }
			  format.json { head :no_content }
			end		
		end
	end
  end
  
  def search
	  if params[:search].blank?  
		redirect_to('index', alert: "Empty field!") and return  
	  elsif params[:search_by]=='title' 
			@results = Book.all.where("lower(title) LIKE ?", "%#{params[:search].downcase}%")
	  elsif params[:search_by]=='authors'
			@results = Book.all.where("lower(authors) LIKE ?", "%#{params[:search].downcase}%")
	  elsif params[:search_by]=='published' 
			@results = Book.all.where("lower(published) LIKE ?", "%#{params[:search].downcase}%")
	  elsif params[:search_by]=='category'
			@results = Book.all.where("lower(category) LIKE ?", "%#{params[:search].downcase}%")
	  else
			redirect_to('index', alert: "Empty field!")
	  end  
  end
  
  def checkout # check if the given book is a special book or not
    @book = Book.find(params[:id])
    if @book.special_collection == true
      if Checkout.where(:student_id => current_student.id , :book_id => @book.id, :return_date => nil).first.nil?
        if SpecialBook.where(:student_id => current_student.id , :book_id => @book.id).first.nil?
          @specialbook_request =  SpecialBook.new(:student_id => current_student.id , :book_id => @book.id)
          @specialbook_request.save!
          flash[:notice] = "Book Hold Request Placed"
        else 
          flash[:notice] = "Book Hold Request Is Already Placed"
        end
      else
        flash[:notice] = "Book Already Checked Out!!!"
      end
    else
      if(@book.count>0)
        
        bs = 2
        ms = 4
        phd = 6
        @z = Student.select('education_level').where(:email => current_student.email)
        @t = Checkout.where(:student_id => current_student.id, :return_date => nil).count
        a=0
        if ((@z.first.education_level == 'B.S.' or @z.first.education_level == 'B.S' or @z.first.education_level =='BS') and (@t>=bs)) or ((@z.first.education_level == 'M.S.' or @z.first.education_level == 'M.S' or @z.first.education_level =='MS') and (@t>=ms)) or ((@z.first.education_level == 'Ph.D' or @z.first.education_level == 'PHD' or @z.first.education_level =='Ph.D.') and (@t>=phd))
          flash[:notice] = "You cannot issue more books. Your request has been added to hold request list."
          a = 1
        else
          if Checkout.where(:student_id => current_student.id , :book_id => @book.id, :return_date => nil).first.nil?
            @checkout = Checkout.new(:student_id => current_student.id , :book_id => @book.id , :issue_date => Date.today , :return_date =>nil , :validity => Library.find(@book.library_id).borrow_limit)
            flash[:notice] = "Book Successfully Checked Out"
            puts params[:id]
            puts @book.count
            @book.decrement(:count)
            puts @book.count
            @user = current_student
            UserMailer.checkout_email(@user,@book).deliver_now
            @checkout.save!
            @book.save!
          else 
            flash[:notice] = "Book Already Checked Out!!"
          end  
        end
      else
        if Checkout.where(:student_id => current_student.id , :book_id => @book.id).first.nil?
          if HoldRequest.where(:student_id => current_student.id , :book_id => @book.id).first.nil?
            @hold_request =  HoldRequest.new(:student_id => current_student.id , :book_id => @book.id)
            @hold_request.save!
            flash[:notice] = "Book Hold Request Placed"
          else 
            flash[:notice] = "Book Hold Request Is Already Placed"
          end
        else
          flash[:notice] = "Book Already Checked Out!!!"
        end
      end
      if !current_student.nil?
        if a==1
          redirect_to books_students_path, noitce: 'You cannot issue more books.'
        end
      end
    end
    redirect_to books_students_path
  end

  def getStudentBookFine
    @checkouts = Checkout.where(:student_id => current_student.id , :return_date => nil )
    if !@checkouts.nil?
      @fines = Array.new
      @checkouts.each do |checkout|
        if checkout.issue_date + checkout.validity < Date.today
          delay = (Date.today - checkout.issue_date).to_i - checkout.validity
          fine_per_day  = Library.find(Book.find(checkout.book_id).library_id).overdue_fines
          @fines.push({:fine_ammount => delay * fine_per_day, :book_id => checkout.book_id})
        else
          @fines.push({:fine_ammount => 0, :book_id => checkout.book_id})
        end
      end
    end
  end

  def getOverdueBooks
    if admin_signed_in?
      @checkouts = Checkout.where(:return_date => nil)
    else
      @checkouts = Checkout.where(:return_date => nil, :book_id => Book.select('id').where(:library_id => Library.select('id').where(:name => current_librarian.library )))
    end    
    if !@checkouts.nil?
      @fines = Array.new
      @checkouts.each do |checkout|
        if checkout.issue_date + checkout.validity < Date.today
          delay = (Date.today - checkout.issue_date).to_i - checkout.validity
          fine_per_day  = Library.find(Book.find(checkout.book_id).library_id).overdue_fines
          @fines.push({:fine_ammount => delay * fine_per_day, :book_id => checkout.book_id , :student_id => checkout.student_id})
        else
          @fines.push({:fine_ammount => 0, :book_id => checkout.book_id ,:student_id => checkout.student_id})
        end
      end
    end
  end

  def viewHoldRequestForLibrarian
    @holdreqs = HoldRequest.where(:book_id => Book.where(:library_id => Library.select('id').where(:name => current_librarian.library) ))
  end

  def viewBookHistory
    @checkouts = Checkout.where.not(:return_date => nil ).where(:book_id => params[:id])
  end

  def returnBook
    @book = Book.find(params[:id])
    if(@book.count>0) 
      if !Checkout.where(:student_id => current_student.id , :book_id => @book.id, :return_date => nil).first.nil?
        @checkout = Checkout.where(:student_id => current_student.id , :book_id => @book.id, :return_date => nil).first
        @checkout.update( :return_date => Date.today)
        @checkout.save!
        flash[:notice] = "Book Successfully returned"
        @user = current_student
        UserMailer.returnbook_email(@user,@book).deliver_now
        @book.increment(:count)
        @book.save!
      else 
        flash[:notice] = "Book is not checked out"
      end  
    else
      if !Checkout.where(:student_id => current_student.id , :book_id => @book.id,:return_date => nil).nil?
        @hold_request = HoldRequest.where(:book_id => @book.id).first
        if @hold_request.nil?
          @checkout = Checkout.where(:student_id => current_student.id , :book_id => @book.id , :return_date => nil)
          @checkout.update( :return_date => Date.today)
          flash[:notice] = "Book Successfully returned"
          @user = current_student
          UserMailer.returnbook_email(@user,@book).deliver_now
          @book.increment(:count)
          @book.save!
        else
          @checkout = Checkout.where(:student_id => current_student.id , :book_id => @book.id )
          @checkout.update( :return_date => Date.today)
          @checkout_new = Checkout.new(:student_id => @hold_request.student_id , :book_id => @hold_request.book_id , :issue_date => Date.today , :return_date =>nil , :validity => Library.find(@book.library_id).borrow_limit)
          @checkout_new.save!
          flash[:notice] = "Book Successfully returned"
          UserMailer.checkout_email(User.find(@hold_request.student_id),@book).deliver_now
          @hold_request.destroy
        end
      end
    end
	  redirect_to action: "getBookmarkBooks"
  end

  def bookmark
    @book = Book.find(params[:id])
    @bookmark = Bookmark.where(:student_id => current_student.id , :book_id => @book.id).first
    if !@bookmark.nil?
      flash[:notice] = "Book is already bookmarked!!"
    else
      @bookmark = Bookmark.new(:student_id => current_student.id , :book_id => @book.id);
      @user = current_student
      UserMailer.bookmark_email(@user,@book).deliver_now
      @bookmark.save!
      flash[:notice] = "Book Added to your bookmarks"
    end
	
	if !current_student.nil?
		redirect_to books_students_path
	else
		redirect_to action: "index"
	end
    # Transaction.
        # find_or_initialize_by(:isbn => @book.isbn , :email => current_student.email).
        # update_attributes!(:email => current_student.email,:bookmarks => true)
    # redirect_to action: "index"
  end

  def unbookmark
    @book = Book.find(params[:id])
    @bookmark = Bookmark.where(:student_id => current_student.id , :book_id => @book.id).first
    if !@bookmark.nil?
      @bookmark.destroy
      flash[:notice] = "Bookmark Removed succefully!!"
    else
      flash[:notice] = "Bookmark not found!!"
    end
    redirect_to action: "getBookmarkBooks"
  end


  def requestBook
    @book = Book.find(params[:id])
    @transaction = Transaction.where(:isbn => @book.isbn , :email => current_student.email, :request => true).first
    if !@transaction.nil?
      flash[:notice] = "Book is already Requested!!"
    else
      flash[:notice] = "Book Added to your Requested Lists"
    end
    Transaction.
        find_or_initialize_by(:isbn => @book.isbn , :email => current_student.email).
        update_attributes!(:email => current_student.email,:request => true)
    redirect_to action: "index"
  end

  def repealRequest
    @book = Book.find(params[:id])
    if @book.special_collection == true
      @special_book = SpecialBook.where(:book_id => @book.id, :student_id => current_student.id).first
      @special_book.destroy
    else
      @hold_request = HoldRequest.where(:book_id => @book.id).first
      @hold_request.destroy
    end
    redirect_to action: "getBookmarkBooks"
  end
  
  def librarian_book_view
    @books = Book.all.where(:library_id => Library.select('id').where(:name => current_librarian.library))
  end

  def librarian_special_book
    @special_books = SpecialBook.all.where(:book_id => Book.where(:library_id => Library.select('id').where(:name => current_librarian.library)))
  end

  def approve_special_book
    @special_book_id = params[:id]
    @special_book  = SpecialBook.find(@special_book_id)
    puts  @special_book.book_id
    @book  = Book.find(@special_book.book_id)
    @checkout = Checkout.new(:student_id => @special_book.student_id , :book_id => @special_book.book_id , :issue_date => Date.today , :return_date =>nil , :validity => Library.find(@book.library_id).borrow_limit)
    flash[:notice] = "Book Successfully Checked Out"
    @book.decrement(:count)
    @user = Student.find(@special_book.student_id)
    UserMailer.checkout_email(@user,@book).deliver_now
    @special_book = SpecialBook.find(@special_book_id)
    @special_book.destroy
    @checkout.save!
    @book.save!
    redirect_to action: "librarian_special_book"
  end

  def reject_special_book
    @books = SpecialBook.find(params[:id])
    @books.destroy
    redirect_to action: "librarian_special_book"
  end

  def getBookmarkBooks
    # @book = Book.find(params[:id])
    @bookmark = Book.where(id: Bookmark.select('book_id').where(:student_id => current_student.id))
    @checkout = Book.where(id: Checkout.select('book_id').where(:return_date =>nil, :student_id => current_student.id))
    hold_request = Book.where(id: HoldRequest.select('book_id').where(:student_id => current_student.id))
    special_book = Book.where(id: SpecialBook.select('book_id').where(:student_id => current_student.id))
    @request  = hold_request + special_book
    #redirect_to action: "index"
  end

  def list_checkedoutBooks
    #ook.where(isbn: Transaction.select('isbn').where(email: current_student.email,bookmarks: true))
    @books = Book.where(id: Checkout.select('book_id').where(:return_date =>nil))
  end

  def viewHoldRequestForAdmin
    @holdreqs = HoldRequest.all
    render "viewHoldRequestForLibrarian"
  end

  def viewBookHistory
    @checkouts = Checkout.where.not(:return_date => nil ).where(:book_id => params[:id])
  end  
  
  def list_checkedoutBooksAndStudentsAdmin
	#@results = Checkout.joins('INNER JOIN Students s ON s.id = Checkouts.student_id INNER JOIN Books b ON b.id = Checkouts.book_id')
	@results = Checkout.select(:'students.name',:'students.email',:'students.education_level',:'students.university',:'books.isbn',:'books.title',:'books.authors',:issue_date,:return_date,:'books.language',:'books.published',:'books.edition',:'books.subject',:'books.summary',:'books.category',:'books.special_collection').joins(:student).joins(:book)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:isbn, :title, :authors, :language, :published, :edition, :cover, :subject, :summary, :category, :special_collection, :library_id, :count)
    end

end
