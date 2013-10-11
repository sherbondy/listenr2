class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    alert = UIAlertView.new
    alert.addButtonWithTitle('Done')
    alert.cancelButtonIndex = 0
    alert.message = "Hello there!"
    alert.show
    true
  end
end
