class CreateIceCreamComments < ActiveRecord::Migration
  def change
    create_table :ice_cream_comments do |t|
      t.string :content
      t.belongs_to :ice_cream
      t.timestamps null: false
    end
  end
end
