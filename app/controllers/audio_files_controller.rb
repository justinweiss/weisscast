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
  
  def destroy
    @audio_file = AudioFile.find(params[:id])
    if @audio_file.destroy
      flash[:notice] = 'Audio file was successfully deleted.'
      redirect_to audio_files_url
    else
      redirect_to audio_files_url
    end
    
  end
  
  def index
    @now_playing = 
      begin
        open('http://localhost:8000/now_playing').read
      rescue
        "Server not started"
      end      
    @audio_files = AudioFile.find(:all, :order => "artist, album, title")
    @audio_queue = AudioQueue.find(:all, :order => :position)
  end
end
