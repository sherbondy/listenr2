class Object
  def presence
    if self.to_s.empty?
      nil
    else
      self
    end
  end
end

class DashboardVC < UITableViewController

  def fetchPosts
    if @tumblr.user.logged_in?
      @tumblr.client.dashboard({'type' => 'audio'}, callback: lambda do |response, error|
        if !error
          @data = response['posts']
          self.tableView.reloadData
        else
          puts error.localizedDescription
        end
        self.refreshControl.endRefreshing
      end)
    end
  end

  def init
    super
    @audio_player = AudioPlayer.instance
    self
  end
  
  def viewDidLoad
    self.title = 'Dashboard'
    @data = []
    self.tableView.dataSource = self
    self.tableView.delegate = self
    @tumblr = Tumblr.instance

    self.refreshControl = UIRefreshControl.new
    self.refreshControl.addTarget(self, action:'refresh:', forControlEvents:UIControlEventValueChanged);

    fetchPosts    
  end

  def refresh(sender)
    fetchPosts
  end
  
  def viewWillAppear(animated)
    navBar = self.navigationController.navigationBar
    navBar.barTintColor = UIColor.purpleColor
    navBar.translucent = false
  end

  ### dataSource Methods

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuseIdentifier ||= "SONG_CELL"

    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier) || begin
      UITableViewCell.alloc.initWithStyle(UITableViewCellStyleSubtitle, reuseIdentifier:@reuseIdentifier)
    end

    song = @data[indexPath.row]

    cell.textLabel.text = song['track_name'].presence || "Unknown Track"
    cell.detailTextLabel.text = "#{(song['artist'].presence || "Unknown Artist")} - #{(song['album'].presence || "Unknown Album")}"

    cell
  end

  def tableView(tableView, numberOfRowsInSection: section)
    @data.count
  end

  ### delegate Methods
  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    @audio_player.play_song(@data[indexPath.row])
  end
  
end