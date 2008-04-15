require 'open-uri'

class AudioFilesController < ApplicationController
  
  def new
    @audio_file = AudioFile.new
  end
  
  def create
    @audio_file = AudioFile.new(params[:audio_file])
    if @audio_file.save
      flash[:notice] = 'Audio file was successfully uploaded.'
      redirect_to audio_files_url  
    else
      render :action => :new
    end
    
  end
  
  def index
    @now_playing = open('http://localhost:8000/now_playing').read
    @audio_files = AudioFile.find(:all)
    @audio_queue = AudioQueue.find(:all, :order => :position)
  end
end
