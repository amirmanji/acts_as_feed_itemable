require File.dirname(__FILE__) + '/lib/acts_as_feed_itemable'
require File.dirname(__FILE__) + '/lib/abstract_feed_item'
ActiveRecord::Base.send(:include, FeedItemable)
