module ActsAsFeedItemable
  def self.included(base)
    base.extend(ClassMethods)
  end
	
  module ClassMethods
    def acts_as_feed_itemable(options = {})
      config = { :with_flag => nil }
      config.update(options)
      
      has_one :feed_item, :as => :item, :dependent => :destroy
      
      if config[:with_flag]      
        flag = config[:with_flag].to_s
        
        mod = Module.new
        mod.module_eval do
          define_method :need_new_feed_item? do
            self.send(flag) && (self.new_record? || !self.send(flag + "_was"))
          end
          
          define_method :feed_item_eligible? do
            true
          end
          
          define_method :process_feed_item do
            feed_item.destroy if feed_item && !(self.send(flag))
		        FeedItem.create(:user => self.user, :item => self) if need_new_feed_item? && feed_item_eligible?
          end
        end
        
        include mod
        after_save :process_feed_item
      else
        include ActsAsFeedItemable::DefaultInstanceMethods
        after_create :process_feed_item
      end
    end
  end
  
  module DefaultInstanceMethods
    def feed_item_eligible?
      true
    end
    
    def process_feed_item
      FeedItem.create(:user => self.user, :item => self) if feed_item_eligible?
    end
  end
end

ActiveRecord::Base.send(:include, ActsAsFeedItemable)
