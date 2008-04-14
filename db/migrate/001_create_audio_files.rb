class CreateAudioFiles < ActiveRecord::Migration
  def self.up
    create_table :audio_files do |t|
      t.string :path

      t.timestamps
    end
  end

  def self.down
    drop_table :audio_files
  end
end
