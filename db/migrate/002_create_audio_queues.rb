class CreateAudioQueues < ActiveRecord::Migration
  def self.up
    create_table :audio_queues do |t|
      t.integer :audio_file_id
      t.integer :position

      t.timestamps
    end
  end

  def self.down
    drop_table :audio_queues
  end
end
