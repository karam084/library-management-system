class LibrariansController < ApplicationController
  #include Accessible
  #before_action authenticate
  before_action :set_librarian, only: [:show, :edit, :update, :destroy]
  
  # def authenticate!
    # if !current_admin.nil? 
        # :authenticate_admin!
	# elsif !current_librarian.nil?
		# :authenticate_librarian!
    # end
  # end

  # GET /librarians
  # GET /librarians.json
  def index
    if admin_signed_in?
      sign_out :librarian
      redirect_to admins_path
	  elsif student_signed_in?
      sign_out :librarian
      redirect_to students_path, notice: 'Action not allowed.'
    else
      @lib = Librarian.find_by(:email => current_librarian.email)
      if @lib.approved == 'No'
      redirect_to restricted_path
      else
        library_name = current_librarian.library
        puts library_name
        @library = Library.all.where(:name => library_name).first
        @librarians = Librarian.all
      end
    end
  end
  
  def restricted
  if student_signed_in?
      sign_out :librarian
      redirect_to students_path, notice: 'Action not allowed.'
    end
  end

  def home_page
  if student_signed_in?
      sign_out :librarian
      redirect_to students_path, notice: 'Action not allowed.'
    end

  end

  # GET /librarians/1
  # GET /librarians/1.json
  def show
  if student_signed_in?
      sign_out :librarian
      redirect_to students_path, notice: 'Action not allowed.'
    end
  end

  # GET /librarians/new
  def new
  if student_signed_in?
      sign_out :librarian
      redirect_to students_path, notice: 'Action not allowed.'
    else
		if !current_librarian.nil?
			@lib = Librarian.find_by(:email => current_librarian.email)
			  if @lib.approved == 'No'
				redirect_to restricted_path
			  else
				@librarian = Librarian.new
			  end
		else
			@librarian = Librarian.new
		end
	 end
  end

  # GET /librarians/1/edit
  def edit
  if student_signed_in?
      sign_out :librarian
      redirect_to students_path, notice: 'Action not allowed.'
    end
  end

  # POST /librarians
  # POST /librarians.json
  def create
  if student_signed_in?
      sign_out :librarian
      redirect_to students_path, notice: 'Action not allowed.'
    else
		@librarian = Librarian.new(librarian_params)

		respond_to do |format|
		  if @librarian.save
			format.html { redirect_to @librarian, notice: 'Librarian was successfully created.' }
			format.json { render :show, status: :created, location: @librarian }
		  else
			format.html { render :new }
			format.json { render json: @librarian.errors, status: :unprocessable_entity }
		  end
		end
	end
  end

  # PATCH/PUT /librarians/1
  # PATCH/PUT /librarians/1.json
  def update
	if student_signed_in?
      sign_out :librarian
      redirect_to students_path, notice: 'Action not allowed.'
    else
		respond_to do |format|
		  if @librarian.update(librarian_params)
			format.html { redirect_to @librarian, notice: 'Librarian was successfully updated.' }
			format.json { render :show, status: :ok, location: @librarian }
		  else
			format.html { render :edit }
			format.json { render json: @librarian.errors, status: :unprocessable_entity }
		  end
		end
	end
  end

  # DELETE /librarians/1
  # DELETE /librarians/1.json
  def destroy
	if student_signed_in?
      sign_out :librarian
      redirect_to students_path, notice: 'Action not allowed.'
    else
		@librarian.destroy
		if current_admin.nil? 
			respond_to do |format|
			  format.html { redirect_to librarians_url, notice: 'Librarian was successfully destroyed.' }
			  format.json { head :no_content }
			end
		else
			respond_to do |format|
			  format.html { redirect_to show_librarians_path, notice: 'Librarian was successfully removed.' }
			  format.json { head :no_content }
			end		
		end
	end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_librarian
      @librarian = Librarian.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def librarian_params
      params.require(:librarian).permit(:name, :email, :password, :library, :approved)
    end
end
