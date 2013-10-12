class AppDelegate
  
  def application(application, didFinishLaunchingWithOptions:launchOptions) 
    @papaVC = MainVC.new

    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = @papaVC

    @window.makeKeyAndVisible

    puts "hello there..."
    true
  end
  
  def application(application, openURL:url, sourceApplication:source, annotation:annotation)
    return @tumblr.client.handleOpenURL(url)
  end
end
