class AudioPlayer

  def setup_audio_session
    UIApplication.sharedApplication.beginReceivingRemoteControlEvents
    AVAudioSession.sharedInstance.setDelegate(self)
    AVAudioSession.sharedInstance.setCategory(AVAudioSessionCategoryPlayback, error:nil)
    AVAudioSession.sharedInstance.setActive(true, error:nil)
  end

	def player
    if !@player
      setup_audio_session()
    end
    @player ||= AVPlayer.new
  end

  def self.instance
    Dispatch.once { @instance ||= new }
    @instance
  end

  def play_song(song_hash)
    url = nil

    if song_hash.key?('audio_url')
      full_url_str =  song_hash['audio_url']
      if song_hash['audio_url'].include?("www.tumblr.com")
        full_url_str += "?plead=please-dont-download-this-or-our-lawyers-wont-let-us-host-audio"
      end
      url = NSURL.URLWithString(full_url_str)
      puts url.absoluteString
    end

    if url
      player_item = AVPlayerItem.alloc.initWithURL(url)
      player.replaceCurrentItemWithPlayerItem(player_item)
      player.play
    else
      puts "no audio url #{song_hash}"
    end
  end

end