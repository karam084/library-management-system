class LibrariesController < ApplicationController
    def index
        @libraries = Library.all
    end
    
    def show
        @library = Library.find(params[:id])
    end

    def new
        @library = Library.new
    end

    def edit
        @library = Library.find(params[:id])
    end

    def create
        @library = Library.new(library_params)
        if @library.save
            redirect_to @library
        else
            render 'new'
        end
    end

    def update
        @library = Library.find(params[:id])
        if @library.update(library_params)
            redirect_to @library
        else
            render 'edit'
        end
    end

    def destroy
        @library = Library.find(params[:id])
        @library.destroy
        redirect_to libraries_path
    end

    private
    def library_params
        params.require(:library).permit(:name, :address, :phone)
    end
end
