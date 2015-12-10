class AddDefaultSizesToCollections < ActiveRecord::Migration
  def change
    add_column :collections, :default_sizes, :string, null: false, default: ''
  end
end
