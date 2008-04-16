class AudioQueuesController < ApplicationController
  def create
    @audio_queue = AudioQueue.new(params[:audio_queue])
    if @audio_queue.save
      flash[:notice] = 'Audio file was added to the playlist.'
      redirect_to audio_files_url
    else
      redirect_to audio_files_url
    end
    
  end
end
