class GenresController < ApplicationController
  def show
    # binding.pry
    @genre = Genre.find_by(name: params[:genre])
  end
end
