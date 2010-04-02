class AbstractFeed < ActiveRecord::Base
  self.abstract_class = true
  
  DISPLAY_LIMIT = 10
  
  belongs_to :feed_item
  belongs_to :user
  
  validates_presence_of :feed_item, :user
  before_save :set_item_type

  named_scope :for_item_type, lambda { |item_type| { :conditions => [ 'item_type = ?', item_type ] } }
  
  def item
    self.feed_item.item
  end
  
  def set_item_type
    self.item_type = feed_item.item_type
  end
end
