# manages the PlayBarView and handles interactions with the AVPlayer

class PlayBarVC < UIViewController

  BAR_HEIGHT = 32
  LABEL_HEIGHT = 12
  LABEL_WIDTH = (Device.screen.width - 2*BAR_HEIGHT)
  LABEL_TOP = 4

  def init
    super

    @title_label = UILabel.new
    @subtitle_label = UILabel.new
    @album_art = UIImageView.new
    @play_button = UIButton.buttonWithType(UIButtonTypeCustom)
    @play_button.addTarget(self, action:'toggle_playback:', forControlEvents:UIControlEventTouchUpInside)

    @audio_player = AudioPlayer.instance

    self
  end

  def active?
    !@audio_player.currentItem.nil?
  end

  def loadView
    play_bar = UIView.new
    play_bar.backgroundColor = UIColor.purpleColor

    @play_button.setTitle('Play')
    play_bar.addSubview(@play_button)

    play_bar.addSubview(@album_art)

    @title_label.text = "Unknown Title"
    @title_label.textAlignment = NSTextAlignmentCenter
    @title_label.textColor = UIColor.whiteColor
    play_bar.addSubview(@title_label)

    @subtitle_label.text = "Unknown Artist - Unknown Album"
    @subtitle_label.textAlignment = NSTextAlignmentCenter
    @subtitle_label.textColor = UIColor.whiteColor
    play_bar.addSubview(@subtitle_label)

    self.view = play_bar
  end

  def viewWillLayoutSubviews
    super
    puts "bar will lay out subviews"
    self.view.frame = CGRect.make(x: 0, y: (Device.screen.height - BAR_HEIGHT), w: Device.screen.width, h: BAR_HEIGHT)
    puts self.view.frame.size.width
    @play_button.frame = CGRect.make(x: 0, y:0, w: BAR_HEIGHT, h: BAR_HEIGHT)
    @album_art.frame = CGRect.make(x: (Device.screen.width - BAR_HEIGHT), y: 0, w: BAR_HEIGHT, h: BAR_HEIGHT)
    @title_label.frame = CGRect.make(x: BAR_HEIGHT, y: LABEL_TOP, w: LABEL_WIDTH, h: LABEL_HEIGHT)
    @subtitle_label.frame = @title_label.frame + CGPoint.make(x: 0, y: (LABEL_TOP + LABEL_HEIGHT))
  end

end