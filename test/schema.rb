ActiveRecord::Schema.define(:version => 0) do
  create_table :users, :force => true do |t|
    t.string    :username,    :null => false
    t.datetime  :created_at
    t.datetime  :updated_at
  end
  
  create_table :feed_items, :force => true do |t|
    t.integer  :user_id,      :null => false
    t.integer  :item_id,      :null => false
    t.string   :item_type,    :null => false
    t.datetime :created_at
    t.datetime :updated_at
  end
  
  create_table :waffles, :force => true do |t|
    t.integer   :user_id,     :null => false
    t.boolean   :tasty,       :null => false,   :default => false
    t.name      :string
    t.datetime  :created_at
    t.datetime  :updated_at
  end
  
  create_table :pancakes, :force => true do |t|
    t.integer   :user_id,     :null => false
    t.boolean   :tasty,       :null => false,   :default => false
    t.name      :string
    t.datetime  :created_at
    t.datetime  :updated_at
  end
end