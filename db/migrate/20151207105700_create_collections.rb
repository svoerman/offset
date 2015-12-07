class CreateCollections < ActiveRecord::Migration
  def change
    create_table :collections do |t|
      t.string :name,       null: false, default: ''
      t.references :user,   null: false
      t.timestamps
    end

    add_index :collections, :user_id
  end
end
