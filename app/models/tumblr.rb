class Tumblr  
  def self.instance
    Dispatch.once { @instance ||= new }
    @instance
  end
  
  def client
    if !@client
      @client = TMAPIClient.sharedInstance
      @client.OAuthConsumerKey = Secrets::TUMBLR_OAUTH_KEY
      @client.OAuthConsumerSecret = Secrets::TUMBLR_OAUTH_SECRET
    end
    @client
  end
  
  def login(&callback)
    @user = User.new
    
    if @user.logged_in?
      self.client.OAuthToken = @user.oauth_token
      self.client.OAuthTokenSecret = @user.oauth_secret
      callback.call
    else
      self.client.authenticate('listenr', callback: lambda do |error|
        if !error
          puts "Logged in!"
          @user.store_creds(self.client.OAuthToken, self.client.OAuthTokenSecret)
          callback.call
        else
          puts error.localizedDescription
        end
      end)
    end
  end
  
  
end