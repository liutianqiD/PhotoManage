class OauthController < ApplicationController
  include Oauth
  require 'net/http'
  require 'uri'
  require 'json'

  def callback
    uri = URI.parse(token_endpoint(params[:code]))
    req = Net::HTTP::Post.new(uri)
    req.set_form_data({'client_id' => client_id,
                        'client_secret' => client_secret,
                        'code' => params[:code],
                        'redirect_uri' => redirect_uri,
                        'grant_type' => 'authorization_code'})
    req_options = {
      use_ssl: uri.scheme == "https"
    }
    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(req)
    end

    session[:access_token] = JSON.parse(response.body)["access_token"]
    redirect_to photos_url
  end
end
