module ImageSpec

  class GIF

    def self.dimensions(file)
      file.read(4, 6).unpack('SS')
    end

  end

end
