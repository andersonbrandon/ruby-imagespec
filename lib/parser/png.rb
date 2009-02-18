class ImageSpec

  module Parser

    class PNG

      def self.png?(stream)
        stream.rewind
        stream.read(4) == "\x89PNG"
      end

      def self.dimensions(file)
        file.seek(0x10)
        file.read(8).unpack('NN')
      end

    end

  end

end
