require 'open-uri'
require File.join(File.dirname(__FILE__), 'parser')

class ImageSpec

  attr_reader :width, :height

  def initialize(file)
    stream   = stream_for(file)
    filename = stream.path || file

    @width, @height = Parser.parse(stream)
  end

  private

  def stream_for(file)
    if file.respond_to?(:read)
      file
    elsif file.is_a?(String)
      open(file, 'rb')
    else
      raise "Unable to get stream for #{file.inspect}"
    end
  end

end
