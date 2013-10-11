class AppDelegate
  @@tumblr = TMAPIClient.sharedInstance
  
  def alertUserInfo
    @@tumblr.userInfo(lambda do |info, error|
      if !error
        puts info
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
    
    @@tumblr.authenticate('listenr', callback: lambda do |error|
      if !error
        puts "Logged in!"
        alertUserInfo()
      else
        puts error.localizedDescription
      end
    end)
    
    puts "hello there..."
    true
  end
  
  def application(application, openURL:url, sourceApplication:source, annotation:annotation)
    return @@tumblr.handleOpenURL(url)
  end
end