class ArtistsController < ApplicationController
  def index
    matching_artists = Artist.all

    @list_of_artists = matching_artists.order({ :created_at => :desc })

    render({ :template => "artists/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_artists = Artist.where({ :id => the_id })

    @the_artist = matching_artists.at(0)

    render({ :template => "artists/show" })
  end

  def create
    the_artist = Artist.new
    the_artist.name = params.fetch("query_name")
    the_artist.photo = params.fetch("query_photo")
    the_artist.birth_year = params.fetch("query_birth_year")
    the_artist.country = params.fetch("query_country")
    the_artist.user_artist_id = params.fetch("query_user_artist_id")
    the_artist.inspiration_id = params.fetch("query_inspiration_id")
    the_artist.visibility = params.fetch("query_visibility", false)
    the_artist.artworks_count = params.fetch("query_artworks_count")

    if the_artist.valid?
      the_artist.save
      redirect_to("/artists", { :notice => "Artist created successfully." })
    else
      redirect_to("/artists", { :alert => the_artist.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_artist = Artist.where({ :id => the_id }).at(0)

    the_artist.name = params.fetch("query_name")
    the_artist.photo = params.fetch("query_photo")
    the_artist.birth_year = params.fetch("query_birth_year")
    the_artist.country = params.fetch("query_country")
    the_artist.user_artist_id = params.fetch("query_user_artist_id")
    the_artist.inspiration_id = params.fetch("query_inspiration_id")
    the_artist.visibility = params.fetch("query_visibility", false)
    the_artist.artworks_count = params.fetch("query_artworks_count")

    if the_artist.valid?
      the_artist.save
      redirect_to("/artists/#{the_artist.id}", { :notice => "Artist updated successfully."} )
    else
      redirect_to("/artists/#{the_artist.id}", { :alert => the_artist.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_artist = Artist.where({ :id => the_id }).at(0)

    the_artist.destroy

    redirect_to("/artists", { :notice => "Artist deleted successfully."} )
  end
end
