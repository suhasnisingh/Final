
 
 # Helper function to fetch and store artworks
 def fetch_and_store_artworks(token)
  artists = Artist.first(10)  # Get the first 10 artists from the database

  artists.each do |artist|
    uri = URI("https://api.artsy.net/api/artists/#{artist.name}/artworks")
    request = Net::HTTP::Get.new(uri)
    request['Authorization'] = "Bearer #{token}"  # Ensure proper token use
    request['Content-Type'] = 'application/json'

    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(request)
      sleep(0.2)  # Delay to maintain rate limit
    end

    if response.is_a?(Net::HTTPSuccess)
      artworks_data = JSON.parse(response.body)
      if artworks_data['_embedded'] && artworks_data['_embedded']['artworks']
        artworks_data['_embedded']['artworks'].first(2).each do |artwork_data|
          # Store artwork details
          title = artwork_data['title']
          medium = artwork_data['medium']
          date = artwork_data['date']
          collecting_institution = artwork_data['collecting_institution']
          thumbnail = artwork_data['_links']['thumbnail']['href'] if artwork_data['_links']['thumbnail']

          Artwork.find_or_create_by(title: title, artist: artist) do |artwork|
            artwork.description = medium
            artwork.year = date
            artwork.location = collecting_institution
            artwork.photo = thumbnail
          end
        end
      else
        puts "No artworks found for artist: #{artist.name}"
      end
    else
      raise "Failed to fetch artworks for artist #{artist.name}: #{response.code} - #{response.message}"
    end
  end
end
