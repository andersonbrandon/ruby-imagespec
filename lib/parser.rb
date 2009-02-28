Dir[File.join(File.dirname(__FILE__), 'parser/*.rb')].each { |parser| require parser }

class ImageSpec

  module Parser

    def self.formats
      @@formats ||= constants.collect { |format| const_get(format) }
    end

    def self.parse(stream)
      formats.each do |format|
        return format.attributes(stream) if format.detected?(stream)
      end
      raise "#{stream.inspect} is not a supported image format. Sorry bub :("
    end

  end

end
