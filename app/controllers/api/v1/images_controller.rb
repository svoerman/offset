class Api::V1::ImagesController < Api::V1::ApiController
  before_filter :load_collection
  before_filter :load_image, only: :thumbnail
  skip_before_action :verify_authenticity_token

  def index
    # current_resource_owner.collections
    render json: { images: @collection.images, user: current_resource_owner }
  end

  def create
    @image = @collection.images.new(image_params)
    if @image.save
      render json: { image: @image }
    else
      render json: { error: 'Ohoh, not a valid image' }
    end
  end

  def thumbnail
    style = "#{params['width']}x#{params['height']}>"
    render json: { url: @image.dynamic_attachment_url(style), height: style }
  end

  private

  def image_params
    params.require(:image).permit(:name, :attachment, :author_name, :author_email)
  end

  def load_image
    @image = Image.find(params[:id])
  end

  def load_collection
    @collection = current_resource_owner.collections.find_by_id(params[:collection_id])
  end
end