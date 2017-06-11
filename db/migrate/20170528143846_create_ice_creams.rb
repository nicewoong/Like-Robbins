class CreateIceCreams < ActiveRecord::Migration
  def change
    create_table :ice_creams do |t|
      t.string :name
      t.integer :number
      t.string :imageURL
      t.string :short_description
      t.string :keywords
      t.integer :selectedCount
      t.timestamps null: false
    end
  end
end
