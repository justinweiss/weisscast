class AddTrackInfoFields < ActiveRecord::Migration
  def self.up
    add_column :audio_files, :artist, :string
    add_column :audio_files, :album, :string
    add_column :audio_files, :title, :string
  end

  def self.down
    remove_column :audio_files, :artist
    remove_column :audio_files, :album
    remove_column :audio_files, :title
  end
end
