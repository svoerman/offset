class Image < ActiveRecord::Base
  belongs_to :collection
  after_create :generate_default_sizes

  has_attached_file :attachment,
                    styles: Proc.new { |attachment| attachment.instance.styles },
                    default_url: "/images/:style/missing.png"

  validates :collection, presence: true
  validates :attachment,
            attachment_size: { less_than: 20.megabytes },
            attachment_content_type: { content_type: /^image\/(jpg|jpeg|pjpeg|png|x-png|gif)$/, message: 'file type is not allowed (only jpeg/png/gif images)' }

  def styles
    return {} if @dynamic_style_format.blank?
    dynamic_style_hash(@dynamic_style_format)
  end

  def dynamic_style_hash(format)
    { dynamic_style_format_symbol(@dynamic_style_format) => @dynamic_style_format }
  end

  def dynamic_style_format_symbol(format = '')
    URI.escape(format).to_sym
  end

  def dynamic_attachment_url(format)
    @dynamic_style_format = format
    format_symbol = dynamic_style_format_symbol(format)
    attachment.reprocess!(format_symbol) unless attachment.exists?(format_symbol)
    attachment.url(format_symbol)
  end

  def generate_default_sizes
    collection.default_sizes_ar.map { |s| dynamic_attachment_url(s) }
  end
end

