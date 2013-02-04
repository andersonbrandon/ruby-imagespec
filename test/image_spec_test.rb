require 'test/unit'

require 'image_spec'

class ImageSpecTest < Test::Unit::TestCase
  # Replace this with your real tests.

  def setup
  	@swf_file_path = "/home/jplopez/development/adxion_300x250.swf"
  end

  def test_swf_parser_version_attribute
	instance = ImageSpec.new(@swf_file_path)
	assert_not_nil instance
	assert_not_nil instance.version
  end
end
