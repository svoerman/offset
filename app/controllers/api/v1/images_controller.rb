class Api::V1::ImagesController < Api::V1::ApiController
  before_filter :load_collection
  def index
    # current_resource_owner.collections
    render json: { images: @collection.images, user: current_resource_owner }
  end

  private
  
  def load_collection
    @collection = current_resource_owner.collections.find_by_id(params[:collection_id])
  end
end