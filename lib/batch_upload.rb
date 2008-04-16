server_name, directory = ARGV

Dir["#{directory}/**/*.mp3"].each do |file|
  `curl -H "Accept:text/xml" -F "audio_file[uploaded_data]=@#{file};type=audio/mpeg" http://#{server_name}/audio_files`
end