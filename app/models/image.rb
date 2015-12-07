class Image < ActiveRecord::Base
  belongs_to :collection

  has_attached_file :attachment,
                    styles: Proc.new { |attachment| attachment.instance.styles },
                    default_url: "/images/:style/missing.png"

  validates_attachment_content_type :attachment, content_type: /\Aimage\/.*\Z/
  validates :collection, :presence => true

  def styles
    return {} if @dynamic_style_format.blank?
    { dynamic_style_format_symbol => @dynamic_style_format }
  end

  def dynamic_style_format_symbol
    URI.escape(@dynamic_style_format).to_sym
  end

  def dynamic_attachment_url(format)
    @dynamic_style_format = format
    format_symbol = dynamic_style_format_symbol
    attachment.reprocess!(format_symbol) unless attachment.exists?(format_symbol)
    attachment.url(format_symbol)
  end
end

