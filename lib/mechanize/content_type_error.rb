class Mechanize
  # =Synopsis
  # This class contains an error for when a pluggable parser tries to
  # parse a content type that it does not know how to handle.  For example
  # if Mechanize::Page were to try to parse a PDF, a ContentTypeError
  # would be thrown.
  class ContentTypeError < Mechanize::Error
    attr_reader :content_type

    def initialize(content_type)
      @content_type = content_type
    end
  end
end
