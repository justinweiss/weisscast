require 'id3lib'
require 'iconv'

class AudioFile < ActiveRecord::Base
  has_many :audio_queues, :dependent => :destroy
  has_attachment :content_type => 'audio/mpeg', :storage => :file_system, :path_prefix => 'public/music', :size => 500.kilobytes..10.megabytes
  validates_as_attachment
  
  def tag
    @tag ||= ID3Lib::Tag.new(self.full_filename)
  end
  
  def convert_if_necessary(string)
    if /^\xFE\xFF/ =~ string
      Iconv.new('utf-8//IGNORE', 'utf-16').iconv(string)
    else
      string
    end
  end
  
  after_attachment_saved do |record|
    record.artist = record.convert_if_necessary(record.tag.artist)
    record.album = record.convert_if_necessary(record.tag.album)
    record.title = record.convert_if_necessary(record.tag.title)
    record.save!
  end
  
  def display_name
    [self.artist, self.title].join(' - ')
  end
  
end
