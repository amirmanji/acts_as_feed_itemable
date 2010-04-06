module FeedItemable
  def self.included(base)
    base.extend(ClassMethods)
  end
	
  module ClassMethods
    def acts_as_feed_itemable(options = {})
      config = { :on_create => true, :on_update => false, :use_flag => nil }
      
      config.update(options)
      
      has_one :feed_item, :as => :item, :dependent => :destroy
      
      after_create(:generate_feed_item) if (config[:on_create])
      after_update(:generate_feed_item) if (config[:on_update])
      
      if config[:use_flag]      
        flag = config[:use_flag].to_s
        
        mod = Module.new
        mod.module_eval do
          define_method :feed_item_eligible? do
            feed_item.destroy if feed_item && !(self.send(flag))
            self.send(flag) && (self.new_record? || !self.send(flag + "_was"))
          end
        end
        
        include mod
        include FeedItemable::InstanceMethods
      else
        include FeedItemable::DefaultEligibilityMethods
        include FeedItemable::InstanceMethods
      end
    end
  end
  
  module DefaultEligibilityMethods
    def feed_item_eligible?
      true
    end
  end
	
	module InstanceMethods
    def generate_feed_item
		  FeedItem.create(:user => self.user, :item => self) if feed_item_eligible?
	  end
	end
end

