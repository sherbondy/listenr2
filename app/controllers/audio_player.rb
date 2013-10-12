class AudioPlayer

	def player
    @player ||= AVPlayer.new
  end

  def self.instance
    Dispatch.once { @instance ||= new }
    @instance
  end

  def play_song(song_hash)
    url = nil

    if song_hash.key?('audio_url')
      full_url_str =  song_hash['audio_url'] + "?plead=please-dont-download-this-or-our-lawyers-wont-let-us-host-audio"
      url = NSURL.URLWithString(full_url_str)
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