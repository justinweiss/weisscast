require 'id3lib'

class AudioFile < ActiveRecord::Base
  has_many :audio_queues
  has_attachment :content_type => 'audio/mpeg', :storage => :file_system, :path_prefix => 'public/music', :size => 500.kilobytes..10.megabytes
  validates_as_attachment
  validates_uniqueness_of :filename
  
  def tag
    @tag ||= ID3Lib::Tag.new(self.full_filename)
  end
  
  after_attachment_saved do |record|
    record.artist = record.tag.artist
    record.album = record.tag.album
    record.title = record.tag.title
    record.save!
  end
  
  def display_name
    [self.artist, self.title].join(' - ')
  end
  
end
