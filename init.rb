require File.dirname(__FILE__) + '/lib/acts_as_feed_itemable'
require File.dirname(__FILE__) + '/lib/abstract_feed_item'
require File.dirname(__FILE__) + '/lib/abstract_feed'
require File.dirname(__FILE__) + '/lib/generate_feeds_job'
ActiveRecord::Base.send(:include, FeedItemable)
