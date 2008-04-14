class AudioFile < ActiveRecord::Base
  has_many :audio_queues
end
