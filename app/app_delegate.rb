class AppDelegate
  
  def alertUserInfo
    @tumblr.client.userInfo(lambda do |info, error|
      if !error
        puts info
        # store these values securely!
        puts "Tumblr Token: #{@tumblr.client.OAuthToken}"
        puts "Tumblr Secret: #{@tumblr.client.OAuthTokenSecret}"
        
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
    @tumblr = Tumblr.instance
    @tumblr.login do 
      alertUserInfo
    end

    puts "hello there..."
    true
  end
  
  def application(application, openURL:url, sourceApplication:source, annotation:annotation)
    return @tumblr.client.handleOpenURL(url)
  end
end