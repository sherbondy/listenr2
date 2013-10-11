class DashboardVC < UITableViewController
  
  def viewDidLoad
    self.title = 'Dashboard'
  end
  
  def viewWillAppear(animated)
    self.navigationController.navigationBar.barTintColor = UIColor.purpleColor
  end
  
end