class FeedItemMigration < ActiveRecord::Migration
  def self.up
    create_table :feed_items do |t|
      t.references :user, :null => false
      t.references :item, :polymorphic => true, :null => false
      t.timestamps
    end
    
    add_index :feed_items, [ :item_type, :item_id, :user_id ], :unique => true
    add_index :feed_items, [ :user_id, :item_type ]
  end

  def self.down
    drop_table :feed_items
  end
end
