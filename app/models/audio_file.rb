class AudioFile < ActiveRecord::Base
  has_many :audio_queues
  has_attachment :content_type => 'audio/mpeg', :storage => :file_system, :path_prefix => 'public/music', :size => 500.kilobytes..10.megabytes
  validates_as_attachment
  validates_uniqueness_of :filename
  
  def tag
    ID3Lib::Tag.new(self.filename)
  end
  
end
