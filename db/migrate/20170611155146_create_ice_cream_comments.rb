class CreateIceCreamComments < ActiveRecord::Migration
  def change
    create_table :ice_cream_comments do |t|
      
      t.belongs_to :ice_cream #t.integer :ice_cream_id 와 같음. 
      t.string :content
      
      t.timestamps null: false
    end
  end
end
