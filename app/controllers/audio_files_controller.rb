class AudioFilesController < ApplicationController
  
  def new
    @audio_file = AudioFile.new
  end
  
  def create
    @audio_file = AudioFile.new(params[:audio_file])
    if @audio_file.save
      flash[:notice] = 'Audio file was successfully created.'
      redirect_to audio_file_url(@audio_file)     
    else
      render :action => :new
    end
    
  end
  
  def index
    @audio_files = AudioFile.find(:all)
  end
end
