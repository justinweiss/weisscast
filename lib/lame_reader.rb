class LameReader
  
  attr_reader :output_streams
  
  attr_reader :queue
  
  def initialize
    @output_streams = []
    @queue = []
    @stopped = true
  end
  
  def stopped?
    @stopped == true
  end
  
  def next_track
    queue.pop
  end
  
  def play
    
    @stopped = false
    while (fn = self.next_track) && !stopped?
      RAILS_DEFAULT_LOGGER.debug "Playing #{fn}"
    
      IO.popen("lame --quiet --preset 128 #{fn} -") do |trans|
        while data = trans.read(128*1024/8)

          @output_streams.each do |response|
            begin
              response.write(data)
            rescue
              @output_streams.delete(response)
              response.done
            end
          end
          sleep 1
        end
      end
    end
    
  end
  
  def stop
    @output_streams.each do |response|
      response.done
    end
    @stopped = true
  end
  
end


class ActiveRecordLameReader < LameReader
  def next_track
    track = AudioQueue.find(:first, :order => :position)
    filename = track && track.audio_file.public_filename
    AudioQueue.destroy(track)
  end
end