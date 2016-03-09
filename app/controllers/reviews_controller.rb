class ReviewsController < ApplicationController
  def new
    @album = Album.find_by(slug: params[:album_id])
    @review = Review.new
  end

  def create
    @album = Album.find_by(slug: params[:album_id])
    @review = @album.reviews.create(review_params)
    if @review.save
      redirect_to @album
    else
      render :new
    end
  end

  private

  def review_params
    params.require(:review).permit(:comment, :album_id)
  end
end
