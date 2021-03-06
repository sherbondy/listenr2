class Tumblr
  
  def self.instance
    Dispatch.once { @instance ||= new }
    @instance
  end

  def user
    @user ||= User.new
  end
  
  def client
    if !@client
      @client = TMAPIClient.sharedInstance
      @client.OAuthConsumerKey = Secrets::TUMBLR_OAUTH_KEY
      @client.OAuthConsumerSecret = Secrets::TUMBLR_OAUTH_SECRET
    end
    @client
  end

  def load_credentials
    if user.logged_in?
      client.OAuthToken = user.oauth_token
      client.OAuthTokenSecret = user.oauth_secret
    end
  end
  
  def login(&callback)
    if !user.logged_in?
      client.authenticate('listenr', callback: lambda do |error|
        if !error
          puts "Logged in!"
          user.store_creds(client.OAuthToken, client.OAuthTokenSecret)
          callback.call
        else
          puts error.localizedDescription
        end
      end)
    end
  end

  def logout
    user.reset
    client.OAuthToken = nil
    client.OAuthTokenSecret = nil
  end
  
  
end
