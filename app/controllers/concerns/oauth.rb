module Oauth
  extend ActiveSupport::Concern

  def authorize_endpoint
    oauth_base_url + "/authorize?" + "client_id=" + client_id + "&response_type=code" + "&redirect_uri=" + redirect_uri + "&scope=" + "&state="
  end

  def token_endpoint(code)
    oauth_base_url + "/token"
  end

  def twitter_endpoint
    "https://arcane-ravine-29792.herokuapp.com/api/tweets"
  end

  def oauth_base_url
    "https://arcane-ravine-29792.herokuapp.com/oauth"
  end

  def redirect_uri
    "http://localhost:3000/oauth/callback"
  end

  def client_id
    "7c65b07b948aa48042d9d09800f7f019b13d5ff03ece3cdeee4832ab995e7db2"
  end
  def client_secret
    "50b1caa4a949713166483b0a175cff6ec608831e36f5e2e4b024fe8e67fe415f"
  end
end
