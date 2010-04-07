class FeedItem < ActiveRecord::Base
  belongs_to :item, :polymorphic => true
  belongs_to :user
  
  validates_presence_of :item, :user
end