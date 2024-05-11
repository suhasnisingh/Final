require 'net/http'
require 'json'

namespace :populate do
  desc "Populate the Artists and Artworks tables from Artsy's public API"

  # Helper function to fetch the Artsy access token
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
      raise "Failed to fetch Artsy token: #{response.code} - #{response.message}"
    end
  end

  # Function to fetch artists from the first page with valid dob and insert them into the Artist table
  def fetch_and_insert_artists(token)
    uri = URI("https://api.artsy.net/api/artists?size=200") # Fetch 200 artists from the first page
    request = Net::HTTP::Get.new(uri)
    request['X-Xapp-Token'] = token.strip
    request['Content-Type'] = 'application/json'

    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(request)
    end

    if response.is_a?(Net::HTTPSuccess)
      artists_data = JSON.parse(response.body)
      artists = artists_data['_embedded']['artists']

      artists.each do |artist|
        next unless artist['birthday'] && artist['birthday'].to_i > 0 # Skip artists without a valid dob

        # Insert artist into the database
        Artist.create!(
          artist_api_id: artist['id'],
          name: artist['name'],
          birth_year: artist['birthday'],
          photo: artist['thumbnail'] ? artist['thumbnail']['image_url'] : nil
        )
      end

      puts "Inserted #{artists.length} artists into the database"
    else
      raise "Failed to fetch artists from Artsy: #{response.code} - #{response.message}"
    end
  end

  task :art => :environment do
    token = get_artsy_access_token

    fetch_and_insert_artists(token)
  end
end
