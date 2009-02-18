module ImageSpec

  class PNG

    def self.dimensions(file)
      file.read(8, 0x10).unpack('NN')
    end

  end

end
