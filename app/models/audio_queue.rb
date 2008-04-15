class AudioQueue < ActiveRecord::Base
  belongs_to :audio_file
  
  
  def self.pop_audio_file
    queue_entry = find(:first, :order => :position)
    if queue_entry

      audio_file = queue_entry.audio_file 
      destroy(queue_entry)
      audio_file
    else
      random_audio_file
    end
  end
  
  def self.random_audio_file
    AudioFile.find(:first, {:offset => rand(AudioFile.count)})
  end
end
