class Api::V1::CollectionsController < Api::V1::ApiController
  def index
    # current_resource_owner.collections
    render json: { hello: 'world', user: current_resource_owner }
  end
end