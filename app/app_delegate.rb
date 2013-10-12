class AppDelegate

  def tumblr
    @tumblr ||= Tumblr.instance
  end
  
  def alertUserInfo
    tumblr.client.userInfo(lambda do |info, error|
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
  
  def login_title
    if tumblr.user.logged_in? then "Logout" else "Login" end
  end
  
  def application(application, didFinishLaunchingWithOptions:launchOptions) 
    @dashVC = DashboardVC.new
    @navController = UINavigationController.alloc.initWithRootViewController(@dashVC)

    @login_button = BW::UIBarButtonItem.styled(:plain, login_title) do
      if tumblr.user.logged_in?
        tumblr.logout
        @login_button.title = login_title
      else
        tumblr.login do
          alertUserInfo
          @login_button.title = login_title
        end
      end
    end

    tumblr.load_credentials

    @dashVC.navigationItem.rightBarButtonItem = @login_button

    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = @navController
    @window.makeKeyAndVisible

    puts "hello there..."
    true
  end
  
  def application(application, openURL:url, sourceApplication:source, annotation:annotation)
    return @tumblr.client.handleOpenURL(url)
  end
end
