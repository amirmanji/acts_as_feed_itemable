class User < ActiveRecord::Base
  has_many :feed_items
end

class FeedItem < ActiveRecord::Base
  belongs_to :item, :polymorphic => true
  belongs_to :user
  validates_presence_of :item, :user
end

class Waffle < ActiveRecord::Base
  acts_as_feed_itemable
  belongs_to :user
end

class Pancake < ActiveRecord::Base
  acts_as_feed_itemable :with_flag => :tasty
  belongs_to :user
end
