# lib/tasks/populate_artsy.rake
namespace :populate do
  desc "Populate the Artists and Artworks tables from Artsy's public API"
  task :art => :environment do
    require 'net/http'
    require 'json'

    # Step 1: Get the Artsy API access token
    artsy_token = get_artsy_access_token

    # Step 2: Fetch and store artists
    fetch_and_store_artists(artsy_token)

    # Step 3: Fetch and store artworks
    fetch_and_store_artworks(artsy_token)
  end

  # Helper method to fetch the Artsy API access token
  def get_artsy_access_token
    uri = URI('https://api.artsy.net/api/tokens/xapp_token')
    request = Net::HTTP::Post.new(uri)
    request.set_form_data(
      'client_id' => ENV['ARTSY_CLIENT_ID'],
      'client_secret' => ENV['ARTSY_API_KEY']
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
          artist_birthday = artist_data['birthday']
          artist_nationality = artist_data['nationality']
          artist_thumbnail = artist_data['_links']['thumbnail']['href'] if artist_data['_links']['thumbnail']

          Artist.find_or_create_by(name: artist_name) do |artist|
            artist.birth_year = artist_birthday
            artist.country = artist_nationality
            artist.photo = artist_thumbnail
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
          artwork_thumbnail = artwork_data['_links']['thumbnail']['href'] if artwork_data['_links']['thumbnail']
          artwork_medium = artwork_data['medium']
          artwork_date = artwork_data['date']
          collecting_institution = artwork_data['collecting_institution']

          # Find or create the artist from the artwork data
          artist_name = artwork_data['_links']['artists']['href'].split('/').last # assuming artist link
          artist = Artist.find_by(name: artist_name)

          if artist
            Artwork.find_or_create_by(title: artwork_title) do |artwork|
              artwork.photo = artwork_thumbnail
              artwork.description = artwork_medium
              artwork.year = artwork_date
              artwork.location = collecting_institution
              artwork.artist_id = artist.id
            end
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
