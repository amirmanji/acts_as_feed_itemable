class AbstractFeedItem < ActiveRecord::Base
  self.abstract_class = true
  
  DISPLAY_LIMIT = 10
  
  belongs_to :item, :polymorphic => true
  belongs_to :user
  
  validates_presence_of :item, :user
end