module ImageSpec

  class GIF
    
    def self.dimensions(file)
      IO.read(file, 4, 6).unpack('SS')
    end
  
  end
  
end