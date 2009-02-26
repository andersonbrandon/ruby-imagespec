class ImageSpec

  module Parser

    class GIF

      def self.detected?(stream)
        stream.rewind
        stream.read(4) == 'GIF8'
      end

      def self.dimensions(stream)
        stream.seek(6)
        stream.read(4).unpack('SS')
      end

    end

  end

end
