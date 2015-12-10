class Collection < ActiveRecord::Base
  belongs_to :user
  has_many :images

  def default_sizes_ar
    default_sizes.split(',')
  end
end
