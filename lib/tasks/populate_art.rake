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


  def fetch_and_create_artists(token)
    uri = URI('https://api.artsy.net/api/artists')
    request = Net::HTTP::Get.new(uri)
    request['X-Xapp-Token'] = token.strip
    request['Content-Type'] = 'application/json'
  
    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(request)
    end
  
    if response.is_a?(Net::HTTPSuccess)
      artists_data = JSON.parse(response.body)
      if artists_data['_embedded'] && artists_data['_embedded']['artists']
        new_artists_count = 0
        artists_data['_embedded']['artists'].each do |artist|
          puts "we got to artist data: #{artist['name']}"

          break if new_artists_count >= 10
  
          next if artist['birthday'].to_s.empty? || artist['birthday'].to_i <= 1200
  
          uri = URI("https://api.artsy.net/api/artists/#{artist['id']}")
          request = Net::HTTP::Get.new(uri)
          request['X-Xapp-Token'] = token.strip
          request['Content-Type'] = 'application/json'
  
          response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
            http.request(request)
          end
  
          sleep(0.2) # Sleep for rate limiting
  
          if response.is_a?(Net::HTTPSuccess)
            artist_detail = JSON.parse(response.body)
            puts "we got to artist detail: #{artist_detail['name']}"
            Artist.create!(
              artist_api_id: artist_detail['id'],
              name: artist_detail['name'],
              birth_year: artist_detail['birthday'],
              country: artist_detail['nationality']
            )
            new_artists_count += 1
          else
            raise "Failed to fetch detailed artist data from Artsy: #{response.code} - #{response.message}"
          end
        end
      end
    end
  end

  # Main Rake task to populate artists
  task :art => :environment do
    token = get_artsy_access_token

    fetch_and_create_artists(token)
  end

end
