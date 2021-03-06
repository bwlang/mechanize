##
# This class encapsulates links.  It contains the text and the URI for
# 'a' tags parsed out of an HTML page.  If the link contains an image,
# the alt text will be used for that image.
#
# For example, the text for the following links with both be 'Hello World':
#
#   <a href="http://example">Hello World</a>
#   <a href="http://example"><img src="test.jpg" alt="Hello World"></a>

class Mechanize::Page::Link
  attr_reader :node
  attr_reader :href
  attr_reader :text
  attr_reader :attributes
  attr_reader :page
  alias :to_s :text
  alias :referer :page

  def initialize(node, mech, page)
    @node = node
    @href = node['href']
    @text = node.inner_text
    @page = page
    @mech = mech
    @attributes = node

    # If there is no text, try to find an image and use it's alt text
    if (@text.nil? || @text.length == 0) && node.search('img').length > 0
      @text = ''
      node.search('img').each do |e|
        @text << ( e['alt'] || '')
      end
    end

  end

  def uri
    @href && URI.parse(WEBrick::HTTPUtils.escape(@href))
  end

  # A list of words in the rel attribute, all lower-cased.
  def rel
    @rel ||= (val = attributes['rel']) ? val.downcase.split(' ') : []
  end

  # Test if the rel attribute includes +kind+.
  def rel?(kind)
    rel.include?(kind)
  end

  # Click on this link
  def click
    @mech.click self
  end

  # This method is a shorthand to get link's DOM id.
  # Common usage: page.link_with(:dom_id => "links_exact_id")
  def dom_id
    node['id']
  end

end

