class ArtworksController < ApplicationController
  def index
    matching_artworks = Artwork.all

    @list_of_artworks = matching_artworks.order({ :created_at => :desc })

    render({ :template => "artworks/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_artworks = Artwork.where({ :id => the_id })

    @the_artwork = matching_artworks.at(0)

    render({ :template => "artworks/show" })
  end

  def create
    the_artwork = Artwork.new
    the_artwork.title = params.fetch("query_title")
    the_artwork.photo = params.fetch("query_photo")
    the_artwork.description = params.fetch("query_description")
    the_artwork.year = params.fetch("query_year")
    the_artwork.location = params.fetch("query_location")
    the_artwork.artist_id = params.fetch("query_artist_id")
    the_artwork.style_id = params.fetch("query_style_id")
    the_artwork.inspiration_id = params.fetch("query_inspiration_id")
    the_artwork.project_id = params.fetch("query_project_id")
    the_artwork.visibility = params.fetch("query_visibility", false)
    the_artwork.likes_count = params.fetch("query_likes_count")
    the_artwork.comments_count = params.fetch("query_comments_count")

    if the_artwork.valid?
      the_artwork.save
      redirect_to("/artworks", { :notice => "Artwork created successfully." })
    else
      redirect_to("/artworks", { :alert => the_artwork.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_artwork = Artwork.where({ :id => the_id }).at(0)

    the_artwork.title = params.fetch("query_title")
    the_artwork.photo = params.fetch("query_photo")
    the_artwork.description = params.fetch("query_description")
    the_artwork.year = params.fetch("query_year")
    the_artwork.location = params.fetch("query_location")
    the_artwork.artist_id = params.fetch("query_artist_id")
    the_artwork.style_id = params.fetch("query_style_id")
    the_artwork.inspiration_id = params.fetch("query_inspiration_id")
    the_artwork.project_id = params.fetch("query_project_id")
    the_artwork.visibility = params.fetch("query_visibility", false)
    the_artwork.likes_count = params.fetch("query_likes_count")
    the_artwork.comments_count = params.fetch("query_comments_count")

    if the_artwork.valid?
      the_artwork.save
      redirect_to("/artworks/#{the_artwork.id}", { :notice => "Artwork updated successfully."} )
    else
      redirect_to("/artworks/#{the_artwork.id}", { :alert => the_artwork.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_artwork = Artwork.where({ :id => the_id }).at(0)

    the_artwork.destroy

    redirect_to("/artworks", { :notice => "Artwork deleted successfully."} )
  end
end
