class GenresController < ApplicationController
  def show
    @genre = Genre.find_by(name: params[:genre].capitalize)
  end
end
