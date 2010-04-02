class GenerateFeedsJob < Struct.new(:feed_item_id)

  def perform
    feed_item = FeedItem.find(feed_item_id)
    
    if feed_item.user_target
      user_ids_to_feed = (feed_item.user.friends.collect(&:id) + feed_item.user_target.friends.collect(&:id) << feed_item.user.id << feed_item.user_target.id).uniq
    else
      user_ids_to_feed = (feed_item.user.friends.collect(&:id) << feed_item.user.id ).uniq
    end
    
    user_ids_to_feed.each { |f| Feed.create(:user_id => f, :feed_item => feed_item) }
  end

end
