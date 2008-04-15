require 'rubygems'
require 'mongrel'
require 'lame_reader'

class Buffer
  
  attr_reader :closed, :response
  
  def initialize(response)
    @closed = false
    @response = response
  end
  
  def write(data)
    @response.write(data)
  end
  
  def done
    @response.done
    @closed = true
  end
  
end

class StreamHandler < Mongrel::HttpHandler

  def self.media_server
    @media_server
  end
  
  @media_server = ActiveRecordLameReader.new
  
  Thread.new do 
    media_server.play
  end
  
  def media_server
    self.class.media_server
  end
  
  def process(request, response)
    response.status = 200
    response.send_status(nil)

    response.header['Content-Type'] = "audio/mpeg" 
    response.send_header
    
    buffer = Buffer.new(response)
    
    media_server.output_streams << buffer

    until (buffer.closed); sleep 1; end
    puts "Client disconnected"
  end
end

Mongrel::Configurator.new do
  listener :port => 8000 do
    uri "/", :handler => StreamHandler.new
  end
  run; join
end
