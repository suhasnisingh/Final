namespace :test do
  desc "pls work"

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

  task :retrieve => :environment do
    require 'net/http'
    require 'json'

    # Step 1: Retrieve the Artsy access token
    artsy_token = get_artsy_access_token
    print "Retrieved token 2: #{artsy_token}"
  end
  
end
