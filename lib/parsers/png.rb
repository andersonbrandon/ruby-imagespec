class ImageSpec

  class PNG

    def self.dimensions(file)
      file.seek(0x10)
      file.read(8).unpack('NN')
    end

  end

end
