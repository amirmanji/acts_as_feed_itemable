module FeedItemable
  def self.included(base)
    base.extend(ClassMethods)
  end
	
  module ClassMethods
    def acts_as_feed_itemable(options = {})
      config = { :on_create => true, :on_update => false }
      
      config.update(options)
      
      has_one :feed_item, :as => :item, :dependent => :destroy
      
      after_create(:generate_feed_item) if (config[:on_create])
      after_update(:generate_feed_item) if (config[:on_update])
      
      include FeedItemable::InstanceMethods
    end
  end
	
	module InstanceMethods
    def feed_item_eligible?
      true
    end

		def generate_feed_item
		  FeedItem.create(:user => self.user, :item => self) if feed_item_eligible?
	  end
	end
end

