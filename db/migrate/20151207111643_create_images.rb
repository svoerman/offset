class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string      :name,          null: false, default: ''
      t.references  :collection
      t.string      :author_name,   null: false, default: ''
      t.string      :author_email,  null: false, default: ''
      t.text        :description,   null: false, default: ''
      t.integer     :width
      t.integer     :height
      t.text        :exif,          default: ''
      t.boolean     :hidden,        default: false
      t.timestamps
    end

    add_index :images, :collection_id
    add_index :images, :hidden
  end
end
