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


# lib/tasks/populate_artsy.rake
namespace :populate do
  desc "Populate the Artists and Artworks tables from Artsy's public API"
  task :artsy => :environment do
    require 'net/http'
    require 'json'

    artsy_token = get_artsy_access_token # Get the Artsy API access token

    # Fetch and store artists
    fetch_and_store_artists(artsy_token)

    # Fetch and store artworks
    fetch_and_store_artworks(artsy_token)
  end

  # Helper method to get the Artsy API access token
  def get_artsy_access_token
    uri = URI('https://api.artsy.net/api/tokens/xapp_token')
    request = Net::HTTP::Post.new(uri)
    request.set_form_data(
      'client_id' => ENV['ARTSY_CLIENT_ID'],
      'client_secret' => ENV['ARTSY_CLIENT_SECRET']
    )

    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(request)
    end

    if response.is_a?(Net::HTTPSuccess)
      data = JSON.parse(response.body)
      data['token']
    else
      raise "Error fetching Artsy token: #{response.code} - #{response.message}"
    end
  end

  # Helper method to fetch and store artists
  def fetch_and_store_artists(token)
    uri = URI('https://api.artsy.net/api/artists')
    request = Net::HTTP::Get.new(uri)
    request['Authorization'] = "Bearer #{token}"

    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(request)
    end

    if response.is_a?(Net::HTTPSuccess)
      artists_data = JSON.parse(response.body)

      if artists_data['_embedded'] && artists_data['_embedded']['artists']
        artists_data['_embedded']['artists'].each do |artist_data|
          artist_name = artist_data['name']
          artist_bio = artist_data['biography']

          Artist.find_or_create_by(name: artist_name) do |artist|
            artist.bio = artist_bio
          end
        end
      else
        puts "No artists found in the response."
      end
    else
      puts "Failed to fetch artists from Artsy: #{response.code} - #{response.message}"
    end
  end

  # Helper method to fetch and store artworks
  def fetch_and_store_artworks(token)
    uri = URI('https://api.artsy.net/api/artworks')
    request = Net::HTTP::Get.new(uri)
    request['Authorization'] = "Bearer #{token}"

    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(request)
    end

    if response.is_a?(Net::HTTPSuccess)
      artworks_data = JSON.parse(response.body)

      if artworks_data['_embedded'] && artworks_data['_embedded']['artworks']
        artworks_data['_embedded']['artworks'].each do |artwork_data|
          artwork_title = artwork_data['title']
          artist_name = artwork_data['_links']['artists']['href'].split('/').last # Assuming a link to the artist

          artist = Artist.find_by(name: artist_name)

          if artist
            Artwork.find_or_create_by(title: artwork_title, artist: artist)
          else
            puts "Artist not found for artwork: #{artwork_title}"
          end
        end
      else
        puts "No artworks found in the response."
      end
    else
      puts "Failed to fetch artworks from Artsy: #{response.code} - #{response.message}"
    end
  end
end
