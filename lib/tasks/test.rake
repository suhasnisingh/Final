namespace :test do
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

  # Function to fetch artists from a specific page
  def fetch_artists_page(token, page)
    uri = URI("https://api.artsy.net/api/artists?page=#{page}&size=10000") # Fetch 50 artists per page
    request = Net::HTTP::Get.new(uri)
    request['X-Xapp-Token'] = token.strip
    request['Content-Type'] = 'application/json'

    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(request)
    end

    if response.is_a?(Net::HTTPSuccess)
      artists_data = JSON.parse(response.body)
      artists = artists_data['_embedded']['artists']
      return artists || [] # Return an empty array if no artists are retrieved
    else
      raise "Failed to fetch artists from Artsy: #{response.code} - #{response.message}"
    end
  end

  # Function to fetch and create artists with valid birthday and deathday
  def fetch_and_create_artists(token)
    new_artists_count = 0
    page = 1

    puts "Fetching artists - Page #{page}"
    page_artists = fetch_artists_page(token, page)
    puts "Page #{page} retrieved #{page_artists.length} artists"

    page_artists.each do |artist|
      next if artist['birthday'].to_s.empty? && artist['deathday'].to_s.empty?

      # Assuming Artist model has attributes: name, birth_year, death_year, country
      Artist.create!(
        name: artist['name'],
        birth_year: artist['birthday'],
        photo: artist.dig("_links", "thumbnail", "href"),
        country: artist['nationality']
        # Add other attributes as needed
      )

      new_artists_count += 1
      break if new_artists_count >= 10 # Limit to 10 artists
    end

    puts "Total artists retrieved: #{new_artists_count}"
  end

  task :art => :environment do
    token = get_artsy_access_token

    fetch_and_create_artists(token)

    # Now you can populate your database with the retrieved artists
    # Your implementation to populate the database
  end
end
