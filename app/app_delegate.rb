class AppDelegate
  @@tumblr = TMAPIClient.sharedInstance
  
  def alertUserInfo
    @@tumblr.userInfo(lambda do |info, error|
      if !error
        puts info
        # store these values securely!
        puts "Tumblr Token: #{@@tumblr.OAuthToken}"
        puts "Tumblr Secret: #{@@tumblr.OAuthTokenSecret}"
        
        # glorious tumblr api: http://cocoadocs.org/docsets/TMTumblrSDK/1.0.4/Classes/TMAPIClient.html
        alert = UIAlertView.new
        alert.title = 'You are logged in!'
        alert.message = "Hello there, #{info['user']['name']}"
        alert.addButtonWithTitle('Done')
        alert.cancelButtonIndex = 0
        alert.show
      else
        puts error.localizedDescription
      end
    end)
  end
  
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @@tumblr.OAuthConsumerKey = Secrets::TUMBLR_OAUTH_KEY
    @@tumblr.OAuthConsumerSecret = Secrets::TUMBLR_OAUTH_SECRET
    
    @user = User.new
    
    if @user.logged_in?
      @@tumblr.OAuthToken = @user.oauth_token
      @@tumblr.OAuthTokenSecret = @user.oauth_secret
      alertUserInfo()
    else
      @@tumblr.authenticate('listenr', callback: lambda do |error|
        if !error
          puts "Logged in!"
          @user.store_creds(@@tumblr.OAuthToken, @@tumblr.OAuthTokenSecret)
          alertUserInfo()
        else
          puts error.localizedDescription
        end
      end)
    end
    
    puts "hello there..."
    true
  end
  
  def application(application, openURL:url, sourceApplication:source, annotation:annotation)
    return @@tumblr.handleOpenURL(url)
  end
end