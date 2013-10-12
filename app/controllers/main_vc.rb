class MainVC < UIViewController

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

  def init
    super

    tumblr.load_credentials

    @dash_vc = DashboardVC.new
    @nav_controller= UINavigationController.alloc.initWithRootViewController(@dash_vc)

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

    @dash_vc.navigationItem.rightBarButtonItem = @login_button
    self.addChildViewController(@nav_controller)

    @playbar_vc = PlayBarVC.new
    self.addChildViewController(@playbar_vc)

    self
  end

  def loadView
    puts "loading main"
    main_view = UIView.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    main_view.addSubview(@nav_controller.view)
    main_view.addSubview(@playbar_vc.view)
    self.view = main_view
  end

end