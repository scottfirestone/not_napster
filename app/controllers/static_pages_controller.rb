class StaticPagesController < ApplicationController
  def landing
    @discovery_albums = Album.discovery(4)
  end
end
