class AppDelegate
  
  def application(application, didFinishLaunchingWithOptions:launchOptions) 
    @papaVC = MainVC.new

    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = @papaVC

    @window.makeKeyAndVisible

    puts "hello there..."
    true
  end

  def setup_audio_session
    Application.sharedApplication.beginReceivingRemoteControlEvents
    AVAudioSession.sharedInstance.setDelegate(self)
    AVAudioSession.sharedInstance.setCategory(AVAudioSessionCategoryPlayback, error:nil)
    AVAudioSession.sharedInstance.setActive(true, error:nil)
  end
  
  def application(application, openURL:url, sourceApplication:source, annotation:annotation)
    setup_audio_session()
    return @tumblr.client.handleOpenURL(url)
  end
end
